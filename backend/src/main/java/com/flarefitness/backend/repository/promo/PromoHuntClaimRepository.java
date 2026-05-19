package com.flarefitness.backend.repository.promo;

import com.flarefitness.backend.entity.promo.PromoHuntClaim;
import java.util.Collection;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface PromoHuntClaimRepository extends JpaRepository<PromoHuntClaim, String> {

    @Query("select count(claim) from PromoHuntClaim claim where claim.campaignId = :campaignId and (claim.deleted = false or claim.deleted is null) and claim.status = 'ACTIVE'")
    long countByCampaignId(@Param("campaignId") String campaignId);

    @Query("select count(claim) > 0 from PromoHuntClaim claim where claim.campaignId = :campaignId and claim.userId = :userId and (claim.deleted = false or claim.deleted is null) and claim.status = 'ACTIVE'")
    boolean existsByCampaignIdAndUserId(@Param("campaignId") String campaignId, @Param("userId") String userId);

    @Query("select claim from PromoHuntClaim claim where claim.campaignId in :campaignIds and claim.userId = :userId and (claim.deleted = false or claim.deleted is null) and claim.status = 'ACTIVE'")
    List<PromoHuntClaim> findByCampaignIdInAndUserId(@Param("campaignIds") Collection<String> campaignIds, @Param("userId") String userId);
}
