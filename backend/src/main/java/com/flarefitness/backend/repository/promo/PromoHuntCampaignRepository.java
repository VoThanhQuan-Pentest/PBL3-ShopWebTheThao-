package com.flarefitness.backend.repository.promo;

import com.flarefitness.backend.entity.promo.PromoHuntCampaign;
import jakarta.persistence.LockModeType;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface PromoHuntCampaignRepository extends JpaRepository<PromoHuntCampaign, String> {

    @Query("select campaign from PromoHuntCampaign campaign where campaign.status <> 'DELETED' order by campaign.endAt asc")
    List<PromoHuntCampaign> findAllByOrderByEndAtAsc();

    @Lock(LockModeType.PESSIMISTIC_WRITE)
    @Query("select campaign from PromoHuntCampaign campaign where campaign.id = :id and campaign.status <> 'DELETED'")
    Optional<PromoHuntCampaign> findByIdForUpdate(@Param("id") String id);
}
