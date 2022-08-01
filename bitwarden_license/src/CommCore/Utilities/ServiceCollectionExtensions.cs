﻿using Bit.CommCore.Services;
using Bit.Commercial.Infrastructure.EntityFramework;
using Bit.Core.Services;
using Microsoft.Extensions.DependencyInjection;

namespace Bit.CommCore.Utilities
{
    public static class ServiceCollectionExtensions
    {
        public static void AddCommCoreServices(this IServiceCollection services)
        {
            services.AddScoped<IProviderService, ProviderService>();
            services.AddCommercialEFRepositories();
        }
    }
}
