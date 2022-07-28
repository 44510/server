﻿using AutoMapper;
using Bit.Core.Repositories;
using Bit.Infrastructure.EntityFramework.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;

namespace Bit.Infrastructure.EntityFramework.Repositories
{
    public class SecretRepository : Repository<Core.Entities.Secret, Secret, Guid>, ISecretRepository
    {
        public SecretRepository(IServiceScopeFactory serviceScopeFactory, IMapper mapper)
            : base(serviceScopeFactory, mapper, db => db.Secret)
        {

        }

        public async Task<Core.Entities.Secret> GetByIdAsync(Guid id, bool includeDeleted = false)
        {
            using (var scope = ServiceScopeFactory.CreateScope())
            {
                var dbContext = GetDatabaseContext(scope);
                Core.Entities.Secret secret;
                if (includeDeleted)
                {
                    secret = await GetDbSet(dbContext).FindAsync(id);
                }
                else
                {
                    secret = await dbContext.Secret
                                        .Where(c => c.Id == id && c.DeletedDate == null)
                                        .FirstOrDefaultAsync();
                }
                return Mapper.Map<Core.Entities.Secret>(secret);
            }
        }

        public async Task<IEnumerable<Core.Entities.Secret>> GetManyByOrganizationIdAsync(Guid organizationId, bool includeDeleted = false)
        {
            using (var scope = ServiceScopeFactory.CreateScope())
            {
                var dbContext = GetDatabaseContext(scope);

                IQueryable<Secret> query = dbContext.Secret;
                if (includeDeleted)
                {
                    query = query.Where(c => c.OrganizationId == organizationId);
                }
                else
                {
                    query = query.Where(c => c.OrganizationId == organizationId && c.DeletedDate == null);
                }
                return Mapper.Map<List<Core.Entities.Secret>>(await query.ToListAsync());
            }
        }

        public async Task SoftDeleteManyByIdAsync(IEnumerable<Guid> ids)
        {
            using (var scope = ServiceScopeFactory.CreateScope())
            {
                var dbContext = GetDatabaseContext(scope);
                var utcNow = DateTime.UtcNow;
                var secrets = dbContext.Secret.Where(c => ids.Contains(c.Id));
                await secrets.ForEachAsync(secret =>
                {
                    dbContext.Attach(secret);
                    secret.DeletedDate = utcNow;
                    secret.RevisionDate = utcNow;
                });
                await dbContext.SaveChangesAsync();
            }
        }
    }
}
