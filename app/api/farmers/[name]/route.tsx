import { NextRequest, NextResponse } from "next/server";
import prisma from "@/prisma/client";
import { updateSchema } from "../schema";

interface Data {
    active?: boolean;
    nodeIp?: string;
    workers?: number;
    pieceCachePct?: number;
    containerIp?: string;
    nodeName?: string;
    version?: string;
    containerStartedAt?: string;
  }

  export async function GET(
    request: NextRequest,
    { params }: { params: { name: string } }
  ) {
    const farmer = await prisma.farmer.findUnique({
      where: { name: params.name },
    });
  
    if (!farmer)
      return NextResponse.json({
        error: "Farmer not found",
        status: 404,
      });
  
    return NextResponse.json(farmer);
  }

  export async function PUT(
    request: NextRequest,
    { params }: { params: { name: string } }
  ) {
    const body = await request.json();
    const validation = updateSchema.safeParse(body);

    if (!validation.success)
      return NextResponse.json(validation.error.errors, { status: 400 });
  
    const farmer = await prisma.farmer.findUnique({
      where: { name: params.name },
    });
  
    if (!farmer)
      return NextResponse.json({
        error: "Farmer not found",
        status: 404,
      });
  
    const updatableFields: (keyof Data)[] = ["active", "nodeIp", "workers", "pieceCachePct", "containerIp", "nodeName", "version", "containerStartedAt"];
  
    const data = updatableFields.reduce((acc: Data, field) => {
      if (body[field] !== undefined) {
        acc[field] = body[field];
      }
      return acc;
    }, {} as Data);
  
    const updateFarmer = await prisma.farmer.update({
      where: { name: farmer.name },
      data: data,
    });
  
    return NextResponse.json(updateFarmer);

  }

  export async function DELETE(
    request: NextRequest,
    { params }: { params: { name: string } }
  ) {
  
    const farmer = await prisma.farmer.findUnique({
      where: {name: params.name}
    })
  
    if (!farmer)
      return NextResponse.json({
        error: "Farmer not found",
        status: 404,
      });
  
    await prisma.farmer.delete({
      where: {name: farmer.name}
    })
  
    return NextResponse.json({});
  }