import React from "react";

const NodeCard = () => {
  return (
    <div className="card lg:card-side bg-base-100 shadow-xl">
      <div className="card-body">
        <h2 className="card-title">Node</h2>
        <p>Click the button to listen on Spotiwhy app.</p>
        <div className="card-actions justify-end">
          <button className="btn btn-primary">More Info</button>
        </div>
      </div>
    </div>
  );
};

export default NodeCard;
