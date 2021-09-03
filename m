Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9916F400204
	for <lists+linux-scsi@lfdr.de>; Fri,  3 Sep 2021 17:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349674AbhICP0K (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 3 Sep 2021 11:26:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28801 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349648AbhICP0I (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 3 Sep 2021 11:26:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630682708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=71ssT1/FPFNDL4fz1LwnA61MfPkPEiG56dwt3DNF9KI=;
        b=DNGbpIr0/ssgIOZ2gJ+IPwBt6ifjMQI1Sas18EGLoB+szZBB+mwI+3IgxDcLuItjDHVk2e
        biAdOKPNYEwmY9OzvX8hacflebVPTkhloX8ypm4y6eEcpjwa0LHVOmGGH987qHADKHeX8h
        A7cgJDCvDrVsZJd0SaFb9FVm2D2AzTw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-o7yMWoJQO8Waur4aV9Rwqw-1; Fri, 03 Sep 2021 11:25:07 -0400
X-MC-Unique: o7yMWoJQO8Waur4aV9Rwqw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD6F36F301;
        Fri,  3 Sep 2021 15:25:05 +0000 (UTC)
Received: from virtlab512.virt.lab.eng.bos.redhat.com (virtlab512.virt.lab.eng.bos.redhat.com [10.19.152.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 543ED12D4A;
        Fri,  3 Sep 2021 15:24:56 +0000 (UTC)
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, ajit.khaparde@broadcom.com,
        sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
        huangguangbin2@huawei.com, huangdaode@huawei.com,
        mtosatti@redhat.com, juri.lelli@redhat.com, frederic@kernel.org,
        abelits@marvell.com, bhelgaas@google.com, rostedt@goodmis.org,
        peterz@infradead.org
Cc:     nilal@redhat.com, jesse.brandeburg@intel.com, robin.murphy@arm.com,
        mingo@kernel.org, jbrandeb@kernel.org, akpm@linuxfoundation.org,
        sfr@canb.auug.org.au, stephen@networkplumber.org,
        rppt@linux.vnet.ibm.com, chris.friesen@windriver.com,
        maz@kernel.org, nhorman@tuxdriver.com, pjwaskiewicz@gmail.com,
        sassmann@redhat.com, thenzl@redhat.com, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jkc@redhat.com, faisal.latif@intel.com,
        shiraz.saleem@intel.com, tariqt@nvidia.com, ahleihel@redhat.com,
        kheib@redhat.com, borisp@nvidia.com, saeedm@nvidia.com,
        tatyana.e.nikolova@intel.com, mustafa.ismail@intel.com,
        ahs3@redhat.com, leonro@nvidia.com,
        chandrakanth.patil@broadcom.com, bjorn.andersson@linaro.org,
        chunkuang.hu@kernel.org, yongqiang.niu@mediatek.com,
        baolin.wang7@gmail.com, poros@redhat.com, minlei@redhat.com,
        emilne@redhat.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
        kabel@kernel.org, viresh.kumar@linaro.org, kuba@kernel.org,
        kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com,
        sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com, tglx@linutronix.de,
        ley.foon.tan@intel.com, jbrunet@baylibre.com,
        johannes@sipsolutions.net, snelson@pensando.io,
        lewis.hanly@microchip.com, benve@cisco.com, _govind@gmx.com,
        jassisinghbrar@gmail.com
Subject: [PATCH v6 00/14] genirq: Cleanup the abuse of irq_set_affinity_hint()
Date:   Fri,  3 Sep 2021 11:24:16 -0400
Message-Id: <20210903152430.244937-1-nitesh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The drivers currently rely on irq_set_affinity_hint() to either set the
affinity_hint that is consumed by the userspace and/or to enforce a custom
affinity.

irq_set_affinity_hint() as the name suggests is originally introduced to
only set the affinity_hint to help the userspace in guiding the interrupts
and not the affinity itself. However, since the commit

        e2e64a932556 "genirq: Set initial affinity in irq_set_affinity_hint()"

irq_set_affinity_hint() also started applying the provided cpumask (if not
NULL) as the affinity for the interrupts. The issue that this commit was
trying to solve is to allow the drivers to enforce their affinity mask to
distribute the interrupts across the CPUs such that they don't always end
up on CPU0. This issue has been resolved within the irq subsystem since the
commit

        a0c9259dc4e1 "irq/matrix: Spread interrupts on allocation"

Hence, there is no need for the drivers to overwrite the affinity to spread
as it is dynamically performed at the time of allocation.

Also, irq_set_affinity_hint() setting affinity unconditionally introduces
issues for the drivers that only want to set their affinity_hint and not the
affinity itself as for these driver interrupts the default_smp_affinity_mask
is completely ignored (for detailed investigation please refer to [1]).

Unfortunately reverting the commit e2e64a932556 is not an option at this
point for two reasons [2]:

- Several drivers for a valid reason (performance) rely on this API to
  enforce their affinity mask

- Until very recently this was the only exported interface that was
  available

To clear this out Thomas has come up with the following interfaces:

- irq_set_affinity(): only sets affinity of an IRQ [3]
- irq_update_affinity_hint(): Only sets the hint [4]
- irq_set_affinity_and_hint(): Sets both affinity and the hint mask [4]

The first API is already merged in the linus's tree and the patch
that introduces the other two interfaces is included with this patch-set.

To move to the stage where we can safely get rid of the
irq_set_affinity_hint(), which has been marked deprecated, we have to
move all its consumers to these new interfaces. In this patch-set, I have
done that for a few drivers and will hopefully try to move the remaining of
them in the coming days.

The two patches in this series that still needs to be reviewed are:
   be2net: Use irq_update_affinity_hint
   hinic: Use irq_set_affinity_and_hint

any help there will be much appreciated.

Change from v5 [5]
------------------

- Rebased on top of the latest Linus's tree:
	a9c9a6f741cd  "Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi"
- Added reviewed-by/acked-by in the patches


Change from v4 [6]
------------------
- Fixed kernel-doc warnings (Jakub Kicinski)

- Renamed the cover to "Cleanup the abuse of irq_set_affinity_hint()", what
  Thomas originally used as this series is an extension of the work that
  he started and proposed [7].

Change from v3 [8]
------------------
- Replaced irq_set_affinity_and_hint with irq_update_affinity_hint in irdma
  (Leon Romanovsky)
- rebased the patches on top of 5.14-rc2


Change from v2 [9]
------------------

- Rebased on top of 5.14-rc1 (Leon Romanovsky)
  + After discussion with Leon [10], made changes in the mlx5 patch to use
    irq_set_affinity_and_hint over irq_update_affinity_hint
  + i40iw is replaced with irdma driver, hence made the respective changes
    in irdma (also replcaed irq_update_affinity_hint with
    irq_set_affinity_and_hint).

Change from v1 [11]
------------------
- Fixed compilation error by adding the new interface definitions for cases
  where CONFIG_SMP is not defined

- Fixed function usage in megaraid_sas and removed unnecessary variable
  (Robin Murphy)

- Removed unwanted #if/endif from mlx4 (Leon Romanovsky)

- Other indentation related fixes

 
[1] https://lore.kernel.org/lkml/1a044a14-0884-eedb-5d30-28b4bec24b23@redhat.com/
[2] https://lore.kernel.org/linux-pci/d1d5e797-49ee-4968-88c6-c07119343492@arm.com/
[3] https://lore.kernel.org/linux-arm-kernel/20210518091725.046774792@linutronix.de/
[4] https://lore.kernel.org/patchwork/patch/1434326/
[5] https://lore.kernel.org/netdev/20210720232624.1493424-10-nitesh@redhat.com/T/
[6] https://lore.kernel.org/lkml/20210719180746.1008665-1-nitesh@redhat.com/
[7] https://lore.kernel.org/linux-arm-kernel/20210518091725.046774792@linutronix.de/
[8] https://lore.kernel.org/linux-scsi/20210713211502.464259-1-nitesh@redhat.com/
[9] https://lore.kernel.org/lkml/20210629152746.2953364-1-nitesh@redhat.com/
[10] https://lore.kernel.org/lkml/YO0eKv2GJcADQTHH@unreal/
[11] https://lore.kernel.org/linux-scsi/20210617182242.8637-1-nitesh@redhat.com/

Nitesh Narayan Lal (13):
  iavf: Use irq_update_affinity_hint
  i40e: Use irq_update_affinity_hint
  scsi: megaraid_sas: Use irq_set_affinity_and_hint
  scsi: mpt3sas: Use irq_set_affinity_and_hint
  RDMA/irdma: Use irq_update_affinity_hint
  enic: Use irq_update_affinity_hint
  be2net: Use irq_update_affinity_hint
  ixgbe: Use irq_update_affinity_hint
  mailbox: Use irq_update_affinity_hint
  scsi: lpfc: Use irq_set_affinity
  hinic: Use irq_set_affinity_and_hint
  net/mlx5: Use irq_set_affinity_and_hint
  net/mlx4: Use irq_update_affinity_hint

Thomas Gleixner (1):
  genirq: Provide new interfaces for affinity hints

 drivers/infiniband/hw/irdma/hw.c              |  4 +-
 drivers/mailbox/bcm-flexrm-mailbox.c          |  4 +-
 drivers/net/ethernet/cisco/enic/enic_main.c   |  8 +--
 drivers/net/ethernet/emulex/benet/be_main.c   |  4 +-
 drivers/net/ethernet/huawei/hinic/hinic_rx.c  |  4 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  8 +--
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  8 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 10 ++--
 drivers/net/ethernet/mellanox/mlx4/eq.c       |  8 ++-
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c |  8 +--
 drivers/scsi/lpfc/lpfc_init.c                 |  4 +-
 drivers/scsi/megaraid/megaraid_sas_base.c     | 27 +++++-----
 drivers/scsi/mpt3sas/mpt3sas_base.c           | 21 ++++----
 include/linux/interrupt.h                     | 53 ++++++++++++++++++-
 kernel/irq/manage.c                           |  8 +--
 15 files changed, 114 insertions(+), 65 deletions(-)

--  

