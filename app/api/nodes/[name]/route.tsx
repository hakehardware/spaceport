import { NextRequest, NextResponse } from "next/server";
import prisma from "@/prisma/client";
import { updateSchema } from "../schema";

interface Data {
  status?: string;
  active?: boolean;
  hostIp?: string;
  containerIp?: string;
  containerStatus?: string;
  version?: string;
  containerStartedAt?: string;
}

export async function GET(
  request: NextRequest,
  { params }: { params: { name: string } }
) {
  const node = await prisma.node.findUnique({
    where: { name: params.name },
  });

  if (!node)
    return NextResponse.json({
      error: "Node not found",
      status: 404,
    });

  return NextResponse.json(node);
}

export async function PUT(
  request: NextRequest,
  { params }: { params: { name: string } }
) {
  const body = await request.json();
  const validation = updateSchema.safeParse(body);

  if (!validation.success)
    return NextResponse.json(validation.error.errors, { status: 400 });

  const node = await prisma.node.findUnique({
    where: { name: params.name },
  });

  if (!node)
    return NextResponse.json({
      error: "Node not found",
      status: 404,
    });

  const updatableFields: (keyof Data)[] = ["status", "active", "hostIp", "containerIp", "containerStatus", "version", "containerStartedAt"];

  const data = updatableFields.reduce((acc: Data, field) => {
    if (body[field] !== undefined) {
      acc[field] = body[field];
    }
    return acc;
  }, {} as Data);

  const updatedNode = await prisma.node.update({
    where: { name: node.name },
    data: data,
  });

  return NextResponse.json(updatedNode);
}

export async function DELETE(
  request: NextRequest,
  { params }: { params: { name: string } }
) {

  const node = await prisma.node.findUnique({
    where: {name: params.name}
  })

  if (!node)
    return NextResponse.json({
      error: "Node not found",
      status: 404,
    });

  await prisma.node.delete({
    where: {name: node.name}
  })

  return NextResponse.json({});
}