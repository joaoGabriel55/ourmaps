<script>
  import AppLogo from "$lib/components/AppLogo.svelte";
</script>

<div class="h-screen bg-gradient-to-r from-primary to-accent">
  <div class="flex flex-col gap-8 justify-center items-center h-full">
    <AppLogo />
    <div class="card bg-base-100 w-96 shadow-xl">
      <div class="card-body">
        <h2 class="card-title text-3xl">Login</h2>
        <form method="POST">
          <div class="grid gap-6">
            <label class="form-control w-full max-w-xs">
              <div class="label">
                <span class="label-text">Email</span>
              </div>
              <input
                type="email"
                name="email"
                class="input input-bordered w-full max-w-xs"
              />
            </label>
            <label class="form-control w-full max-w-xs">
              <div class="label">
                <span class="label-text">Password</span>
              </div>
              <input
                type="password"
                name="password"
                class="input input-bordered w-full max-w-xs"
              />
            </label>
            <div class="flex flex-col">
              <button class="btn btn-primary">Enter</button>
              <hr class="my-4" />
              <a href="/register" class="btn btn-outline btn-accent">
                Register
              </a>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
