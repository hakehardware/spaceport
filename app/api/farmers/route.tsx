import { NextRequest, NextResponse } from "next/server";
import prisma from "@/prisma/client";
import {createSchema} from "./schema";

export async function GET(request: NextRequest) {
    const nodes = await prisma.farmer.findMany()
    return NextResponse.json(nodes)
}

export async function POST(request: NextRequest) {
    const body = await request.json()
    const validation = createSchema.safeParse(body)

    if (!validation.success)
        return NextResponse.json(validation.error.errors , { status: 400 });

    const node = await prisma.farmer.findUnique({
        where: {
            name: body.name
        }
    })

    if (node)
        return NextResponse.json({error: 'Node already exists'}, {status: 400})

    const newNode = await prisma.farmer.create({
        data: {
            name: body.name,
            active: body.active,
            workers: body.workers,
            pieceCachePct: body.pieceCachePct,
            nodeIp: body.nodeIp,
            containerIp: body.containerIp,
            nodeName: body.nodeName,
            version: body.version,
            containerStartedAt: body.containerStartedAt
        }
    })

    return NextResponse.json(newNode, {status: 201})
}