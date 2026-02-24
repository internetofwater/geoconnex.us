from pathlib import Path
import xml.etree.ElementTree as ET

# The sitemap xml uses 2 namespaces; one for the standard sitemap spec
# and one of our own to add custom attributes for defining the bulk loading process
SITEMAP_NS = "http://www.sitemaps.org/schemas/sitemap/0.9"
GEOCONNEX_NS = "http://geoconnex.us/schemas/sitemap"

NS = {
    "sm": SITEMAP_NS,
    "geoconnex": GEOCONNEX_NS,
}


def assert_valid_xml(xml_path: Path):
    """
    Assert that an XML file is valid for bulk loading according to the Geoconnex specification.
    Fully namespace-aware.
    """
    parsed = ET.parse(xml_path)
    root = parsed.getroot()

    expected_root = f"{{{SITEMAP_NS}}}urlset"
    if root.tag != expected_root:
        raise AssertionError(
            f"Root tag must be 'urlset' in namespace {SITEMAP_NS}, but got {root.tag}"
        )

    url_tags = root.findall("sm:url", NS)
    if not url_tags:
        raise ValueError(f"No urls for containers found in {xml_path}")

    for url_tag in url_tags:
        type_elem = url_tag.find("geoconnex:type", NS)
        if type_elem is None or type_elem.text != "bulk":
            raise ValueError(
                f"Each <url> must contain <geoconnex:type>bulk</geoconnex:type> in {xml_path}"
            )

        container_url = url_tag.find("sm:loc", NS)
        if container_url is None:
            raise ValueError(
                f"Every <url> must have a <loc> child element in {xml_path}"
            )

        container_name = container_url.text
        if not container_name:
            raise ValueError(f"<loc> must contain a container URL in {xml_path}")

        # Simple tag validation; in the future we may want to be more strict and
        # bring in a docker client library for more explicit validation
        if ":" not in container_name or container_name.endswith(":"):
            raise ValueError(
                f"For reproducibility, every image must have a valid tag "
                f"(missing or malformed tag in {xml_path})"
            )
