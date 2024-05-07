import { z } from 'zod';

export const createSchema = z.object({
    name: z.string().min(2),
    active: z.boolean(),
    workers: z.number().optional(),
    pieceCachePct: z.number().optional(),
    nodeIp: z.string().ip(),
    containerIp: z.string().ip(),
    nodeName: z.string(),
    version: z.string(),
    containerStartedAt: z.string().datetime()
})

export const updateSchema = z.object({
    active: z.boolean().optional(),
    workers: z.number().optional().nullable(),
    pieceCachePct: z.number().optional().nullable(),
    nodeIp: z.string().ip().optional(),
    containerIp: z.string().ip().optional(),
    nodeName: z.string().optional().nullable(),
    version: z.string().optional(),
    containerStartedAt: z.string().datetime().optional()
}).refine(data => Object.values(data).some(value => value !== undefined), {
    message: "At least one field must be provided"
  });