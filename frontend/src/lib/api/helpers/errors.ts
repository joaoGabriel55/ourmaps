export const errorHandler = (error: any) => {
  if (!("status" in error)) throw error;

  if ([404, 403].includes(error.status))
    return { status: error.status };

  throw error;
};
