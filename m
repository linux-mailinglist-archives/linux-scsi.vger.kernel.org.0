Return-Path: <linux-scsi+bounces-17761-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C12EBB5805
	for <lists+linux-scsi@lfdr.de>; Thu, 02 Oct 2025 23:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8394D19E7AD1
	for <lists+linux-scsi@lfdr.de>; Thu,  2 Oct 2025 21:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1842737EE;
	Thu,  2 Oct 2025 21:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="sS22lB/3"
X-Original-To: linux-scsi@vger.kernel.org
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935B61E4AB;
	Thu,  2 Oct 2025 21:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759441228; cv=none; b=BBvPV79LpuNanK4chFOczFpTPtlVfv41hIrjl2Ow9ZrTaCs/jZVvmd54Qf9jubXiXZHUAhLcBDLgJc6HtCDGdhPpvvyCLbWOOmpM1f/1GLAHvNQ7DvpL47RD28AUQjgFc4YI08ysSb/rSouGB/gybDB6omRBLqn+7DjxwkYnCT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759441228; c=relaxed/simple;
	bh=bCxxSghvEn7rH94r6dOOMo4pRVzk1w+vLhdxxSFlrLs=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=bTdhNpr8xSkw2LMQ9jtQxFlCYIdVYqsj6LpvRq1svCFbxg9W8Zzgi7hWt8ESDcSOfA/7kt27F1PssEh2rUW+SBYCtblqtfbgOQ9/btXZo1KBckQxnZ+owYk7+2EggsQpHVCikXb5wObdlonGu6NWn5gaqLsnUB6QmlEWaqx+Kbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=sS22lB/3; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1759441224;
	bh=bCxxSghvEn7rH94r6dOOMo4pRVzk1w+vLhdxxSFlrLs=;
	h=Message-ID:Subject:From:To:Date:From;
	b=sS22lB/3bIX4lJw9DdxIQHqybUNOx35xWaVWYaGe+ioMIrU1KqY1NRKcjd3SN29nu
	 ZpfVAIe8mSm7G7thhRaI69HIjlxUv4lxjHL2XUgqjPp97y/cRslDYhvB+htMFyzTqd
	 +ZFJ2lN8kdnc2+ujB5vzU9uaWtIPW7wm3Qabr3jU=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id 259951C0015;
	Thu, 02 Oct 2025 17:40:24 -0400 (EDT)
Message-ID: <0d6775da1dc393821eab88883670b937ef7d8242.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI updates for the 6.17+ merge window
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel
	 <linux-kernel@vger.kernel.org>
Date: Thu, 02 Oct 2025 17:40:23 -0400
Autocrypt: addr=James.Bottomley@HansenPartnership.com;
 prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Usual driver updates (ufs, mpi3mr, lpfc, pm80xx, mpt3sas) plus assorted
cleanups and fixes.  The only core update is to sd.c and is mostly
cosmetic.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

The short changelog is:

Abinash Singh (3):
      scsi: sd: Make sd_revalidate_disk() return void
      scsi: sd: Remove redundant printk() after kmalloc() failure
      scsi: sd: Fix build warning in sd_revalidate_disk()

Alice Chao (4):
      scsi: ufs: host: mediatek: Fix adapt issue after PA_Init
      scsi: ufs: host: mediatek: Correct resume flow for LPM and MTCMOS
      scsi: ufs: host: mediatek: Fix invalid access in vccqx handling
      scsi: ufs: host: mediatek: Assign power mode userdata before FASTAUTO=
 mode change

Alok Tiwari (3):
      scsi: libfc: Fix potential buffer overflow in fc_ct_ms_fill()
      scsi: target: iscsi: fix typos and formatting in lio_target messages
      scsi: ufs: exynos: Correct sync pattern mask timing comment

Bart Van Assche (5):
      scsi: ufs: core: Disable timestamp functionality if not supported
      scsi: ufs: core: Move the tracing enumeration types into a new file
      scsi: ufs: core: Reduce the size of struct ufshcd_lrb
      scsi: ufs: core: Only collect timestamps if monitoring is enabled
      scsi: ufs: core: Improve IOPS

Bharat Uppal (1):
      scsi: ufs: exynos: fsd: Gate ref_clk and put UFS device in reset on s=
uspend

Chandrakanth Patil (6):
      scsi: mpi3mr: Update driver version to 8.15.0.5.50
      scsi: mpi3mr: Fix premature TM timeouts on virtual drives
      scsi: mpi3mr: Update MPI headers to revision 37
      scsi: mpi3mr: Fix I/O failures during controller reset
      scsi: mpi3mr: Fix controller init failure on fault during queue creat=
ion
      scsi: mpi3mr: Fix device loss during enclosure reboot due to zero lin=
k speed

Cryolitia PukNgae (1):
      scsi: hpsa: Fix incorrect comment format

Francisco Gutierrez (1):
      scsi: pm80xx: Fix race condition caused by static variables

Gustavo A. R. Silva (3):
      scsi: pm80xx: Avoid -Wflex-array-member-not-at-end warnings
      scsi: fc: Avoid -Wflex-array-member-not-at-end warnings
      scsi: qla2xxx: Fix memcpy() field-spanning write issue

James Smart (1):
      scsi: MAINTAINERS: Update FC element owners

Justin Tee (14):
      scsi: lpfc: Copyright updates for 14.4.0.11 patches
      scsi: lpfc: Update lpfc version to 14.4.0.11
      scsi: lpfc: Convert debugfs directory counts from atomic to unsigned =
int
      scsi: lpfc: Clean up extraneous phba dentries
      scsi: lpfc: Use switch case statements in DIF debugfs handlers
      scsi: lpfc: Fix memory leak when nvmeio_trc debugfs entry is used
      scsi: lpfc: Define size of debugfs entry for xri rebalancing
      scsi: lpfc: Ensure PLOGI_ACC is sent prior to PRLI in Point to Point =
topology
      scsi: lpfc: Check return status of lpfc_reset_flush_io_context during=
 TGT_RESET
      scsi: lpfc: Decrement ndlp kref after FDISC retries exhausted
      scsi: lpfc: Remove ndlp kref decrement clause for F_Port_Ctrl in lpfc=
_cleanup
      scsi: lpfc: Clean up allocated queues when queue setup mbox commands =
fail
      scsi: lpfc: Abort outstanding ELS WQEs regardless of if rmmod is in p=
rogress
      scsi: lpfc: Remove unused member variables in struct lpfc_hba and lpf=
c_vport

Krzysztof Kozlowski (3):
      scsi: ufs: qcom: dt-bindings: Split SM8650 and similar
      scsi: ufs: qcom: dt-bindings: Split SC7180 and similar
      scsi: ufs: qcom: dt-bindings: Split common part to qcom,ufs-common.ya=
ml

Liao Yuanhong (1):
      scsi: storvsc: Remove redundant ternary operators

Niklas Cassel (10):
      scsi: pm80xx: Use pm80xx_get_local_phy_id() to access phy array
      scsi: pm80xx: Fix pm8001_abort_task() for chip_8006 when using an exp=
ander
      scsi: pm80xx: Add helper function to get the local phy id
      scsi: pm80xx: Use dev_parent_is_expander() helper
      scsi: mvsas: Use dev_parent_is_expander() helper
      scsi: isci: Use dev_parent_is_expander() helper
      scsi: hisi_sas: Use dev_parent_is_expander() helper
      scsi: libsas: Add dev_parent_is_expander() helper
      scsi: pm80xx: Fix array-index-out-of-of-bounds on rmmod
      scsi: pm80xx: Restore support for expanders

Nitin Rawat (2):
      scsi: ufs: ufs-qcom: Refactor MCQ register dump logic
      scsi: ufs: ufs-qcom: Streamline UFS MCQ resource mapping

Palash Kambar (2):
      scsi: ufs: ufs-qcom: Disable lane clocks during phy hibern8
      scsi: ufs: ufs-qcom: Align programming sequence of Shared ICE for UFS=
 controller v5

Peter Wang (16):
      scsi: ufs: core: Change MCQ interrupt enable flow
      scsi: ufs: host: mediatek: Fix device power control
      scsi: ufs: host: mediatek: Fix unbalanced IRQ enable issue
      scsi: ufs: host: mediatek: Disable auto-hibern8 during power mode cha=
nges
      scsi: ufs: host: mediatek: Support UFS PHY runtime PM and correct seq=
uence
      scsi: ufs: host: mediatek: Correct system PM flow
      scsi: ufs: host: mediatek: Enhance recovery on resume failure
      scsi: ufs: host: mediatek: Enhance recovery on hibernation exit failu=
re
      scsi: ufs: host: mediatek: Change reset sequence for improved stabili=
ty
      scsi: ufs: host: mediatek: Fix UniPro setting for MT6989
      scsi: ufs: host: mediatek: Optimize power mode change handling
      scsi: ufs: host: mediatek: Fix PWM mode switch issue
      scsi: ufs: host: mediatek: Fine-tune clock scaling
      scsi: ufs: host: mediatek: Add debug information for Auto-Hibern8
      scsi: ufs: host: mediatek: Fix auto-hibern8 timer configuration
      scsi: ufs: host: mediatek: Simplify variable usage

Qianfeng Rong (10):
      scsi: qla2xxx: Fix incorrect sign of error code in qla_nvme_xmt_ls_rs=
p()
      scsi: qla2xxx: Fix incorrect sign of error code in START_SP_W_RETRIES=
()
      scsi: qla2xxx: edif: Fix incorrect sign of error code
      scsi: lpfc: Use int type to store negative error codes
      scsi: target: iscsi: Use int type to store negative value
      scsi: pm8001: Use int instead of u32 to store error codes
      scsi: lpfc: use min() to improve code
      scsi: hpsa: use min()/min_t() to improve code
      scsi: scsi_debug: Use vcalloc() to simplify code
      scsi: ipr: Use vmalloc_array() to simplify code

Qiang Liu (2):
      scsi: bfa: Remove self-assignment code
      scsi: aic94xx: Remove redundant code

Ram Kumar Dwivedi (4):
      scsi: ufs: ufs-qcom: Add support for limiting HS gear and rate
      scsi: ufs: pltfrm: Add DT support to limit HS gear and gear rate
      scsi: ufs: ufs-qcom: Remove redundant re-assignment to hs_rate
      scsi: ufs: dt-bindings: Document gear and rate limit properties

Ranjan Kumar (4):
      scsi: mpt3sas: Update driver version to 54.100.00.00
      scsi: mpt3sas: Add support for 22.5 Gbps SAS link rate
      scsi: mpt3sas: Suppress unnecessary IOCLogInfo on CONFIG_INVALID_PAGE
      scsi: mpt3sas: Fix crash in transport port remove by using ioc_info()

Sanjeev Y (1):
      scsi: ufs: host: mediatek: Return error directly on idle wait timeout

Thomas Fourier (1):
      scsi: myrs: Fix dma_alloc_coherent() error check

Thorsten Blum (5):
      scsi: smartpqi: Replace kmalloc() + copy_from_user() with memdup_user=
()
      scsi: hpsa: Replace kmalloc() + copy_from_user() with memdup_user()
      scsi: hpsa: Fix potential memory leak in hpsa_big_passthru_ioctl()
      scsi: scsi_debug: Replace kzalloc() + copy_from_user() with memdup_us=
er_nul()
      scsi: qla2xxx: Use secs_to_jiffies() instead of msecs_to_jiffies()

Xichao Zhao (1):
      scsi: csiostor: Fix some spelling errors

Zhongqiu Han (1):
      scsi: ufs: core: Fix data race in CPU latency PM QoS request handling

And the diffstat:

 .../devicetree/bindings/ufs/qcom,sc7180-ufshc.yaml | 167 ++++++
 .../devicetree/bindings/ufs/qcom,sm8650-ufshc.yaml | 178 ++++++
 .../devicetree/bindings/ufs/qcom,ufs-common.yaml   |  67 +++
 .../devicetree/bindings/ufs/qcom,ufs.yaml          | 185 ++----
 .../devicetree/bindings/ufs/ufs-common.yaml        |  16 +
 MAINTAINERS                                        |   9 +-
 drivers/scsi/aic94xx/aic94xx_task.c                |   1 -
 drivers/scsi/bfa/bfa_core.c                        |   1 -
 drivers/scsi/csiostor/csio_wr.c                    |   4 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c              |   2 +-
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c             |   6 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c             |   6 +-
 drivers/scsi/hpsa.c                                |  53 +-
 drivers/scsi/ipr.c                                 |   8 +-
 drivers/scsi/isci/remote_device.c                  |   2 +-
 drivers/scsi/libfc/fc_encode.h                     |   2 +-
 drivers/scsi/libsas/sas_expander.c                 |   5 +-
 drivers/scsi/lpfc/lpfc.h                           |  52 +-
 drivers/scsi/lpfc/lpfc_debugfs.c                   | 633 +++++++----------=
----
 drivers/scsi/lpfc/lpfc_debugfs.h                   |   5 +-
 drivers/scsi/lpfc/lpfc_els.c                       |  23 +-
 drivers/scsi/lpfc/lpfc_hw.h                        |   3 +-
 drivers/scsi/lpfc/lpfc_hw4.h                       |   6 +-
 drivers/scsi/lpfc/lpfc_init.c                      |  12 +-
 drivers/scsi/lpfc/lpfc_nportdisc.c                 |  25 +-
 drivers/scsi/lpfc/lpfc_nvme.c                      |   8 +-
 drivers/scsi/lpfc/lpfc_scsi.c                      |  14 +-
 drivers/scsi/lpfc/lpfc_sli.c                       |  21 +-
 drivers/scsi/lpfc/lpfc_version.h                   |   2 +-
 drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h               |  38 +-
 drivers/scsi/mpi3mr/mpi/mpi30_pci.h                |   2 +
 drivers/scsi/mpi3mr/mpi/mpi30_sas.h                |   1 +
 drivers/scsi/mpi3mr/mpi/mpi30_transport.h          |   2 +-
 drivers/scsi/mpi3mr/mpi3mr.h                       |   8 +-
 drivers/scsi/mpi3mr/mpi3mr_fw.c                    |  13 +
 drivers/scsi/mpi3mr/mpi3mr_os.c                    |  28 +-
 drivers/scsi/mpi3mr/mpi3mr_transport.c             |  11 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c                |   8 +-
 drivers/scsi/mpt3sas/mpt3sas_base.h                |   4 +-
 drivers/scsi/mpt3sas/mpt3sas_transport.c           |  11 +-
 drivers/scsi/mvsas/mv_sas.c                        |   2 +-
 drivers/scsi/myrs.c                                |   8 +-
 drivers/scsi/pm8001/pm8001_ctl.c                   |  24 +-
 drivers/scsi/pm8001/pm8001_hwi.c                   |  11 +-
 drivers/scsi/pm8001/pm8001_hwi.h                   |   4 +-
 drivers/scsi/pm8001/pm8001_init.c                  |   1 +
 drivers/scsi/pm8001/pm8001_sas.c                   |  34 +-
 drivers/scsi/pm8001/pm8001_sas.h                   |   5 +
 drivers/scsi/pm8001/pm80xx_hwi.c                   |  10 +-
 drivers/scsi/pm8001/pm80xx_hwi.h                   |   4 +-
 drivers/scsi/qla2xxx/qla_bsg.c                     |   4 +-
 drivers/scsi/qla2xxx/qla_def.h                     |  10 +-
 drivers/scsi/qla2xxx/qla_edif.c                    |   4 +-
 drivers/scsi/qla2xxx/qla_init.c                    |   4 +-
 drivers/scsi/qla2xxx/qla_isr.c                     |  17 +-
 drivers/scsi/qla2xxx/qla_nvme.c                    |   4 +-
 drivers/scsi/qla2xxx/qla_os.c                      |  13 +-
 drivers/scsi/scsi_debug.c                          |  17 +-
 drivers/scsi/sd.c                                  |  58 +-
 drivers/scsi/smartpqi/smartpqi_init.c              |  17 +-
 drivers/scsi/storvsc_drv.c                         |   4 +-
 drivers/target/iscsi/iscsi_target_configfs.c       |   6 +-
 drivers/target/iscsi/iscsi_target_tmr.c            |   3 +-
 drivers/ufs/core/ufs-mcq.c                         |  11 +
 drivers/ufs/core/ufs-sysfs.c                       |   2 +
 drivers/ufs/core/ufs_trace.h                       |   1 +
 drivers/ufs/core/ufs_trace_types.h                 |  24 +
 drivers/ufs/core/ufshcd.c                          |  60 +-
 drivers/ufs/host/ufs-exynos.c                      |  10 +-
 drivers/ufs/host/ufs-mediatek.c                    | 352 ++++++++++--
 drivers/ufs/host/ufs-mediatek.h                    |   1 +
 drivers/ufs/host/ufs-qcom.c                        | 226 ++++----
 drivers/ufs/host/ufs-qcom.h                        |  28 +-
 drivers/ufs/host/ufshcd-pltfrm.c                   |  33 ++
 drivers/ufs/host/ufshcd-pltfrm.h                   |   1 +
 include/scsi/libsas.h                              |   8 +
 include/uapi/scsi/fc/fc_els.h                      |  58 +-
 include/ufs/ufs.h                                  |  17 -
 include/ufs/ufs_quirks.h                           |   3 +
 include/ufs/ufshcd.h                               |  35 +-
 80 files changed, 1633 insertions(+), 1143 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ufs/qcom,sc7180-ufshc=
.yaml
 create mode 100644 Documentation/devicetree/bindings/ufs/qcom,sm8650-ufshc=
.yaml
 create mode 100644 Documentation/devicetree/bindings/ufs/qcom,ufs-common.y=
aml
 create mode 100644 drivers/ufs/core/ufs_trace_types.h

Regards,

James


