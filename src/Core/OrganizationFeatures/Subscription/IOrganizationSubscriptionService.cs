using System;
using System.Threading.Tasks;
using Bit.Core.Models.Table;

namespace Bit.Core.OrganizationFeatures.Subscription
{
    public interface IOrganizationSubscriptionService
    {
        Task UpdateSubscription(Guid organizationId, int seatAdjustment, int? maxAutoscaleSeats);
        Task AutoAddSeatsAsync(Organization organization, int newSeatsRequired, DateTime? prorationDate = null);
        Task<string> AdjustSeatsAsync(Organization organization, int seatAdjustment, DateTime? prorationDate = null);
    }
}