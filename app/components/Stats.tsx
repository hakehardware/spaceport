import React from "react";

const Stats = () => {
  return (
    <div className="stats shadow">
      <div className="stat">
        <div className="stat-title">Nodes</div>
        <div className="stat-value">1</div>
      </div>

      <div className="stat">
        <div className="stat-title">Farms</div>
        <div className="stat-value">5</div>
      </div>

      <div className="stat">
        <div className="stat-title">Farmers</div>
        <div className="stat-value">20</div>
      </div>

      <div className="stat">
        <div className="stat-title">TiB Space</div>
        <div className="stat-value">42.6</div>
      </div>

      <div className="stat">
        <div className="stat-title">Blocks</div>
        <div className="stat-value">25</div>
      </div>

      <div className="stat">
        <div className="stat-title">Votes</div>
        <div className="stat-value">64</div>
      </div>

      <div className="stat">
        <div className="stat-title">Misses</div>
        <div className="stat-value">3</div>
      </div>

      <div className="stat">
        <div className="stat-title">TSSC</div>
        <div className="stat-value">1405.3</div>
      </div>

    </div>
  );
};

export default Stats;
