import { NextRequest, NextResponse } from "next/server";
import prisma from "@/prisma/client";
import {createSchema} from "./schema";

export async function GET(request: NextRequest) {
    const nodes = await prisma.node.findMany()
    return NextResponse.json(nodes)
}

export async function POST(request: NextRequest) {
    const body = await request.json()
    const validation = createSchema.safeParse(body)

    if (!validation.success)
        return NextResponse.json(validation.error.errors , { status: 400 });

    const node = await prisma.node.findUnique({
        where: {
            name: body.name
        }
    })

    if (node)
        return NextResponse.json({error: 'Node already exists'}, {status: 400})

    const newNode = await prisma.node.create({
        data: {
            name: body.name,
            status: body.status,
            active: body.active,
            hostIp: body.hostIp,
            containerIp: body.containerIp,
            containerStatus: body.containerStatus,
            version: body.version,
            containerStartedAt: body.containerStartedAt
        }
    })

    return NextResponse.json(newNode, {status: 201})
}