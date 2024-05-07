"use client";
import React, { useState, useEffect } from "react";

interface Node {
  name: string;
  createdAt: string;
  updatedAt: string;
  status: string;
  active: boolean;
  ip: string;
}

export default function NodeTable() {
    const [nodes, setNodes] = useState<Node[]>([]);
    const [isRefreshing, setIsRefreshing] = useState(false);


  function fetchNodes() {
    fetch("http://192.168.69.101:3000/api/nodes").then(res => {
         res.json().then( json_data => {
            const data: Node[] = json_data
            setNodes(data);
        })
    })
  }

  useEffect(() => {
    fetchNodes(); // Initial fetch
  }, []);

  useEffect(() => {
    if (isRefreshing) {
      const interval = setInterval(fetchNodes, 5000);
      return () => clearInterval(interval);
    }
  }, [isRefreshing]);

  return (
    <>
      <button onClick={() => setIsRefreshing(!isRefreshing)}>
        {isRefreshing ? "Stop Refreshing" : "Start Refreshing"}
      </button>
      <table className="table table-bordered">
        <thead>
          <tr>
            <th>Name</th>
            <th>Status</th>
            <th>IP</th>
            <th>Active</th>
            <th>Created At</th>
            <th>Updated At</th>
          </tr>
        </thead>
        <tbody>
          {nodes.map((node) => (
            <tr key={node.name}>
              <td>{node.name}</td>
              <td>{node.status}</td>
              <td>{node.ip}</td>
              <td>{node.active ? "Active" : "Inactive"}</td>
              <td>{node.createdAt}</td>
              <td>{node.updatedAt}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </>
  );
}
