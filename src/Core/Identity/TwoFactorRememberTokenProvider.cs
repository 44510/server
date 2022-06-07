﻿using Bit.Core.Entities;
using Microsoft.AspNetCore.DataProtection;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;

#nullable enable

namespace Bit.Core.Identity
{
    public class TwoFactorRememberTokenProvider : DataProtectorTokenProvider<User>
    {
        public TwoFactorRememberTokenProvider(
            IDataProtectionProvider dataProtectionProvider,
            IOptions<TwoFactorRememberTokenProviderOptions> options,
            ILogger<DataProtectorTokenProvider<User>> logger)
            : base(dataProtectionProvider, options, logger)
        { }
    }

    public class TwoFactorRememberTokenProviderOptions : DataProtectionTokenProviderOptions
    { }
}
