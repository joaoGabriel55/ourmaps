export const load = async ({ data }) => {
  return {
    token: data.token,
    userId: data.userId,
  };
};

export const ssr = false;
