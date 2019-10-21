Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC63DE88C
	for <lists+linux-scsi@lfdr.de>; Mon, 21 Oct 2019 11:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbfJUJxc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 21 Oct 2019 05:53:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:48764 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727851AbfJUJxb (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 21 Oct 2019 05:53:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A3F19BAB7;
        Mon, 21 Oct 2019 09:53:28 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH RFC 00/24] scsi: Revamp result values
Date:   Mon, 21 Oct 2019 11:52:58 +0200
Message-Id: <20191021095322.137969-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi all,

the 'result' field in the SCSI command is defined as having
4 fields. The top byte is declared as a 'driver_byte', where the
driver can signal some internal status back to the midlayer.
However, there is quite a bit of overlap between the driver_byte
and the host_byte, resulting in the driver_byte being used in
very few places, and mostly in legacy drivers.
Additionally, we have _two_ sets of definitions for the
last byte (status byte), which can specified either in SAM terms
or in the linux-specific terms, which are shifted right by one
from the SAM ones.
Needless to say, the linux-specific ones are declared obsolete
for years now.
And to make the confusion complete, both the status byte and
the driver byte have a byte for a valid sense code, resulting
in quite some confusion which of those bits to check.

This patchset does several things:
- remove the linux-specific status byte definitions, and use
  the SAM values throughout
- replace the driver-byte values with either SAM ones (for sense
  code checking) or host-byte definitions
- remove the driver-byte definitions

As usual, comments and reviews are welcome.

Please note, commit 66cf50e65b18 ("scsi: qla2xxx: fixup incorrect
usage of host_byte") from 5.4/scsi-fixes is a prerequisite for
this patch series.

Hannes Reinecke (24):
  aic7xxx,aic79xxx: remove driver-defined SAM status definitions
  bfa: drop driver-defined SCSI status codes
  wd33c93: use SCSI status
  acornscsi: use standard defines
  scsi: use standard SAM status codes
  scsi: change status_byte() to return the standard SCSI status
  target_core: Fixup target_complete_cmd() usage
  sg: use SAM status definitions and avoid using masked_status
  scsi: Kill obsolete linux-specific status codes
  scsi: introduce set_status_byte()
  advansys: kill driver_defined status byte accessors
  scsi: introduce scsi_build_sense()
  scsi: Kill DRIVER_SENSE
  scsi: Kill DRIVER_HARD
  scsi_error: use DID_TIME_OUT instead of DRIVER_TIMEOUT
  scsi: Kill DRIVER_TIMEOUT
  scsi: do not use DRIVER_INVALID
  st: return error code in st_scsi_execute()
  scsi_ioctl: return error code when blk_map_user() fails
  scsi_dh_alua: do not interpret DRIVER_ERROR
  xen-scsiback: stop using DRIVER_ERROR
  scsi: stop using DRIVER_ERROR
  scsi: Kill DRIVER_MEDIA, DRIVER_SOFT, and DRIVER_BUSY
  scsi: Drop now obsolete driver_byte definitions

 Documentation/scsi/scsi_mid_low_api.txt     |  3 +-
 block/bsg-lib.c                             |  2 +-
 block/bsg.c                                 |  2 +-
 block/scsi_ioctl.c                          |  9 ++--
 drivers/ata/libata-scsi.c                   | 22 +++-----
 drivers/infiniband/ulp/srp/ib_srp.c         |  2 +-
 drivers/message/fusion/mptscsih.c           |  2 +-
 drivers/s390/scsi/zfcp_scsi.c               |  5 +-
 drivers/scsi/3w-9xxx.c                      |  5 +-
 drivers/scsi/3w-sas.c                       |  3 +-
 drivers/scsi/3w-xxxx.c                      |  7 ++-
 drivers/scsi/53c700.c                       |  6 +--
 drivers/scsi/NCR5380.c                      |  4 +-
 drivers/scsi/advansys.c                     | 78 ++++++++---------------------
 drivers/scsi/aic7xxx/aic79xx_core.c         |  8 +--
 drivers/scsi/aic7xxx/aic79xx_osm.c          | 35 ++++++-------
 drivers/scsi/aic7xxx/aic7xxx_core.c         |  6 +--
 drivers/scsi/aic7xxx/aic7xxx_osm.c          | 13 +++--
 drivers/scsi/aic7xxx/aiclib.h               | 15 ------
 drivers/scsi/arcmsr/arcmsr_hba.c            |  5 +-
 drivers/scsi/arm/acornscsi.c                | 24 +++------
 drivers/scsi/arm/fas216.c                   | 10 ++--
 drivers/scsi/bfa/bfa_fc.h                   | 15 ------
 drivers/scsi/bfa/bfa_fcpim.c                |  2 +-
 drivers/scsi/bfa/bfad_im.c                  |  4 +-
 drivers/scsi/ch.c                           |  5 +-
 drivers/scsi/constants.c                    | 15 ------
 drivers/scsi/cxlflash/superpipe.c           | 45 ++++++++---------
 drivers/scsi/dc395x.c                       | 26 +++-------
 drivers/scsi/device_handler/scsi_dh_alua.c  |  4 --
 drivers/scsi/dpt_i2o.c                      |  2 +-
 drivers/scsi/esp_scsi.c                     |  3 +-
 drivers/scsi/gdth.c                         | 12 ++---
 drivers/scsi/hptiop.c                       |  2 +-
 drivers/scsi/libiscsi.c                     |  5 +-
 drivers/scsi/lpfc/lpfc_scsi.c               | 30 +++--------
 drivers/scsi/megaraid.c                     | 22 ++++----
 drivers/scsi/megaraid/megaraid_mbox.c       | 22 ++++----
 drivers/scsi/megaraid/megaraid_sas_base.c   |  3 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.c |  1 -
 drivers/scsi/mpt3sas/mpt3sas_scsih.c        |  8 +--
 drivers/scsi/mvumi.c                        | 16 +++---
 drivers/scsi/myrb.c                         | 61 ++++++----------------
 drivers/scsi/myrs.c                         |  9 +---
 drivers/scsi/ps3rom.c                       |  3 +-
 drivers/scsi/qla2xxx/qla_isr.c              | 15 ++----
 drivers/scsi/scsi.c                         |  8 +--
 drivers/scsi/scsi_debug.c                   | 15 +++---
 drivers/scsi/scsi_error.c                   | 52 +++++++++----------
 drivers/scsi/scsi_ioctl.c                   |  2 +-
 drivers/scsi/scsi_lib.c                     | 44 +++++++++++-----
 drivers/scsi/scsi_logging.c                 | 10 +---
 drivers/scsi/scsi_scan.c                    |  2 +-
 drivers/scsi/scsi_transport_spi.c           |  2 +-
 drivers/scsi/sd.c                           | 42 ++++++++--------
 drivers/scsi/sd_zbc.c                       |  4 +-
 drivers/scsi/sg.c                           | 25 ++++-----
 drivers/scsi/smartpqi/smartpqi_init.c       |  3 +-
 drivers/scsi/sr.c                           |  2 +-
 drivers/scsi/sr_ioctl.c                     |  2 +-
 drivers/scsi/st.c                           |  8 +--
 drivers/scsi/stex.c                         |  9 ++--
 drivers/scsi/sym53c8xx_2/sym_glue.c         |  6 +--
 drivers/scsi/ufs/ufshcd.c                   |  6 +--
 drivers/scsi/virtio_scsi.c                  |  3 +-
 drivers/scsi/vmw_pvscsi.c                   | 21 ++++----
 drivers/scsi/wd33c93.c                      | 21 +++-----
 drivers/target/loopback/tcm_loop.c          |  1 -
 drivers/target/target_core_alua.c           |  6 +--
 drivers/target/target_core_iblock.c         |  2 +-
 drivers/target/target_core_pr.c             |  8 +--
 drivers/target/target_core_sbc.c            | 10 ++--
 drivers/target/target_core_spc.c            | 14 +++---
 drivers/target/target_core_xcopy.c          |  2 +-
 drivers/usb/storage/cypress_atacb.c         |  4 +-
 drivers/xen/xen-scsiback.c                  | 12 ++---
 include/scsi/scsi.h                         | 19 +------
 include/scsi/scsi_cmnd.h                    | 12 +++--
 include/scsi/scsi_proto.h                   | 19 -------
 include/scsi/sg.h                           |  3 +-
 include/trace/events/scsi.h                 | 15 +-----
 81 files changed, 371 insertions(+), 639 deletions(-)

-- 
2.16.4

