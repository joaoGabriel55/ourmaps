<script lang="ts">
  import AppLogo from "$lib/components/AppLogo.svelte";

  export let form: { error: string };
</script>

<div class="h-screen bg-gradient-to-r from-primary to-accent">
  <div class="flex flex-col gap-8 justify-center items-center h-full">
    <AppLogo />
    <div class="card bg-base-100 w-96 shadow-xl">
      <div class="card-body">
        <h2 class="card-title text-3xl">Register</h2>
        <form method="POST">
          <div class="grid gap-6">
            <label class="form-control w-full max-w-xs">
              <div class="label">
                <span class="label-text">Name</span>
              </div>
              <input
                name="name"
                type="text"
                class="input input-bordered w-full max-w-xs"
                required
              />
            </label>
            <label class="form-control w-full max-w-xs">
              <div class="label">
                <span class="label-text">Email</span>
              </div>
              <input
                name="email"
                type="email"
                class="input input-bordered w-full max-w-xs"
                required
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
                required
              />
            </label>
            <label class="form-control w-full max-w-xs">
              <div class="label">
                <span class="label-text">Confirm Password</span>
              </div>
              <input
                type="password"
                name="confirmPassword"
                class="input input-bordered w-full max-w-xs"
                required
              />
            </label>
            {#if form?.error}
              <p class="text-error text-xs">{form.error}</p>
            {/if}
            <div class="flex flex-col">
              <button class="btn btn-primary" type="submit">
                Create my account
              </button>
              <hr class="my-4" />
              <a href="/login" class="btn btn-outline btn-accent">
                Back to Login
              </a>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
