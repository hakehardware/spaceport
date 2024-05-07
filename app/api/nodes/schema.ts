import { z } from 'zod';

export const createSchema = z.object({
    name: z.string().min(2),
    status: z.enum(['Initializing', 'Idle', 'Syncing']),
    active: z.boolean(),
    hostIp: z.string().ip(),
    containerIp: z.string().ip(),
    containerStatus: z.string(),
    version: z.string(),
    containerStartedAt: z.string().datetime()
})

export const updateSchema = z.object({
    status: z.enum(['Initializing', 'Idle', 'Syncing']).optional(),
    active: z.boolean().optional(),
    hostIp: z.string().ip().optional(),
    containerIp: z.string().ip().optional(),
    containerStatus: z.string().optional(),
    version: z.string().optional(),
    containerStartedAt: z.string().datetime().optional()
}).refine(data => Object.values(data).some(value => value !== undefined), {
    message: "At least one field must be provided"
  });