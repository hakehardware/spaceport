import React from "react";

interface Node {
  name: string;
  createdAt: string;
  updatedAt: string;
  status: string;
  active: boolean;
  hostIp: string;
  containerIp: string;
  containerStatus: string;
  version: string;
  containerStartedAt: string;
}

interface Farm {
  name: string;
  createdAt: string;
  updatedAt: string;
  active: boolean;
  workers: number;
  pieceCachePct: number;
  nodeIp: string;
  containerIp: string;
  version: string;
  containerStartedAt: string;
  nodeName: string;
}

const Stats = async () => {
  const resFarms = await fetch("http://localhost:3000/api/farmers")
  const resNodes = await fetch("http://localhost:3000/api/nodes")
  const nodes: Node[] = await resNodes.json()
  const farms: Farm[] = await resFarms.json()

  return (
    <div className="stats shadow">
      <div className="stat">
        <div className="stat-title">Nodes</div>
        <div className="stat-value">{nodes.length}</div>
      </div>

      <div className="stat">
        <div className="stat-title">Farms</div>
        <div className="stat-value">{farms.length}</div>
      </div>

    </div>
  );
};

export default Stats;
