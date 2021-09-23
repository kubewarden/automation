import argparse

from github import Github


def get_organization_repositories(github, organization):
    return github.get_organization(organization).get_repos()


def try_update_repository_topics(repository, topics):
    try:
        update_repository_topics(repository, topics)
    except Exception as e:
        print(f"Cannot update '{repository.name}: ' {e}")


def update_repository_topics(repository, topics):
    repository_topics = repository.get_topics()
    repository_topics += topics
    print(f"Latest topics for '{repository.name}' repository: {repository_topics} ")
    repository.replace_topics(repository_topics)


def update_repositories_topics(github, organization, topics):
    print(f"Updating repositories from {organization} organization")
    for repository in get_organization_repositories(github, organization):
        try_update_repository_topics(repository, topics)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Script used to update topics for all repositories in Github organization"
    )
    parser.add_argument(
        "-k",
        "--key",
        dest="key",
        type=str,
        action="store",
        help="Personal API key used for authentication",
        required=True,
    )
    parser.add_argument(
        "-o",
        "--org",
        dest="organization",
        type=str,
        action="store",
        help="Organization where the repositories lives. Default: kubewarden",
        default="kubewarden",
    )
    parser.add_argument(
        "topics",
        metavar="T",
        type=str,
        nargs="+",
        help="Topic to be added in the repositories.",
    )
    options = parser.parse_args()
    github = Github(options.key)
    update_repositories_topics(github, options.organization, options.topics)
