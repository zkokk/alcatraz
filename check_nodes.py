import requests
from collections import Counter
import argparse

def hit_load_balancer(url: str, num_requests: int):
    """
    Sends num_requests to the given URL and aggregates hostnames.
    """
    hostnames = []

    for i in range(num_requests):
        try:
            resp = requests.get(url, timeout=5)
            resp.raise_for_status()
            data = resp.json()
            hostnames.append(data.get("hostname", "unknown"))
        except Exception as e:
            print(f"Request {i+1} failed: {e}")

    return hostnames

def summarize(hostnames):
    """
    Prints summary of requests per node.
    """
    counts = Counter(hostnames)
    print("\n=== Node Summary ===")
    for node, count in counts.items():
        print(f"{node}: {count} requests")
    print(f"\nTotal available nodes: {len(counts)}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Hit ALB and count requests per node")
    parser.add_argument("--url", required=True, help="ALB endpoint (e.g., http://my-alb-123456.eu-central-1.elb.amazonaws.com/api/ping)")
    parser.add_argument("--requests", type=int, default=10, help="Number of requests to send")
    args = parser.parse_args()

    hostnames = hit_load_balancer(args.url, args.requests)
    summarize(hostnames)
