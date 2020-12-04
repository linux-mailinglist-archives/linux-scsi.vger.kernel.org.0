Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39552CEB93
	for <lists+linux-scsi@lfdr.de>; Fri,  4 Dec 2020 11:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbgLDKC3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 4 Dec 2020 05:02:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:50434 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbgLDKC3 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 4 Dec 2020 05:02:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8E59CACB5;
        Fri,  4 Dec 2020 10:01:47 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv2 00/37] SCSI result handling cleanup, part 1
Date:   Fri,  4 Dec 2020 11:01:03 +0100
Message-Id: <20201204100140.140863-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi all,

this is the first part of an attempt to clean up SCSI result handling.
The patchset primarily cleans up various drivers by fixing up
whitespaces or move to standard definitions.
It also fixes some minor issues in some drivers which set the
wrong result values.
And, of course, another attempt to kill the gdth driver

I have a larger patchset based on this one to update the SCSI result
handling for all drivers, but decided to split things in two to not
overload reviewers

As usual, comments and reviews are welcome.

Changes to v1:
- Add reviews from Christoph
- Included review from Finn Thain
- Add set_status_byte() helper
- Add cleanup for dc395c
- Add additional patch for using SAM status values instead
  of the shifted linux versions

Hannes Reinecke (37):
  scsi: drop gdth driver
  3w-xxxx: Whitespace cleanup
  3w-9xxx: Whitespace cleanup
  3w-sas: Whitespace cleanup
  atp870u: Whitespace cleanup
  aic7xxx,aic79xx: Whitespace cleanup
  aic7xxx,aic79xx: kill pointless forward declarations
  aic7xxx,aic79xxx: remove driver-defined SAM status definitions
  bfa: drop driver-defined SCSI status codes
  acornscsi: use standard defines
  nsp32: fixup status handling
  dc395: drop private SAM status code definitions
  qla4xxx: use standard SAM status definitions
  zfcp: do not set COMMAND_COMPLETE
  aacraid: avoid setting message byte on completion
  hpsa: do not set COMMAND_COMPLETE
  stex: do not set COMMAND_COMPLETE
  nsp_cs: drop internal SCSI message definition
  aic7xxx,aic79xx: drop internal SCSI message definition
  dc395x: drop internal SCSI message definitions
  initio: drop internal SCSI message definition
  scsi_debug: do not set COMMAND_COMPLETE
  ufshcd: do not set COMMAND_COMPLETE
  atp870u: use standard definitions
  mac53c94: Do not set invalid command result
  dpt_i2o: use DID_ERROR instead of INITIATOR_ERROR message
  scsi: add 'set_status_byte()' accessor
  esp_scsi: use host byte as last argument to esp_cmd_is_done()
  esp_scsi: do not set SCSI message byte
  wd33c93: use SCSI status
  ips: use correct command completion on error
  storvsc: Return DID_ERROR for invalid commands
  qla2xxx: fc_remote_port_chkready() returns a SCSI result value
  advansys: kill driver_defined status byte accessors
  ncr53c8xx: Use SAM status values
  dc395x: drop internal result accessors
  scsi: use non-shifted status values

 Documentation/kbuild/makefiles.rst                 |    4 +-
 Documentation/process/magic-number.rst             |    2 -
 Documentation/scsi/scsi-parameters.rst             |    3 -
 Documentation/userspace-api/ioctl/ioctl-number.rst |    1 -
 drivers/s390/scsi/zfcp_fc.h                        |    1 -
 drivers/scsi/3w-9xxx.c                             |   59 +-
 drivers/scsi/3w-9xxx.h                             |  156 +-
 drivers/scsi/3w-sas.c                              |   52 +-
 drivers/scsi/3w-sas.h                              |  118 +-
 drivers/scsi/3w-xxxx.c                             |  257 +-
 drivers/scsi/3w-xxxx.h                             |  199 +-
 drivers/scsi/Kconfig                               |   14 -
 drivers/scsi/Makefile                              |    2 -
 drivers/scsi/aacraid/aachba.c                      |  173 +-
 drivers/scsi/advansys.c                            |   84 +-
 drivers/scsi/aic7xxx/aic79xx.h                     |   36 +-
 drivers/scsi/aic7xxx/aic79xx_core.c                |  257 +-
 drivers/scsi/aic7xxx/aic79xx_osm.c                 |   20 +-
 drivers/scsi/aic7xxx/aic79xx_osm.h                 |   37 +-
 drivers/scsi/aic7xxx/aic79xx_osm_pci.c             |    6 +-
 drivers/scsi/aic7xxx/aic79xx_proc.c                |   13 +-
 drivers/scsi/aic7xxx/aic7xxx_93cx6.c               |    4 +-
 drivers/scsi/aic7xxx/aic7xxx_core.c                |  263 +-
 drivers/scsi/aic7xxx/aic7xxx_osm.c                 |   88 +-
 drivers/scsi/aic7xxx/aic7xxx_osm.h                 |   39 +-
 drivers/scsi/aic7xxx/aic7xxx_proc.c                |   15 +-
 drivers/scsi/aic7xxx/aiclib.h                      |   15 -
 drivers/scsi/aic7xxx/scsi_message.h                |   41 -
 drivers/scsi/arcmsr/arcmsr_hba.c                   |    2 +-
 drivers/scsi/arm/acornscsi.c                       |   14 +-
 drivers/scsi/atp870u.c                             |  451 +-
 drivers/scsi/atp870u.h                             |   14 +-
 drivers/scsi/bfa/bfa_fc.h                          |   15 -
 drivers/scsi/bfa/bfa_fcpim.c                       |    2 +-
 drivers/scsi/bfa/bfad_im.c                         |    2 +-
 drivers/scsi/dc395x.c                              |  110 +-
 drivers/scsi/dc395x.h                              |   38 -
 drivers/scsi/dpt_i2o.c                             |    2 +-
 drivers/scsi/esp_scsi.c                            |   23 +-
 drivers/scsi/gdth.c                                | 4322 --------------------
 drivers/scsi/gdth.h                                |  981 -----
 drivers/scsi/gdth_ioctl.h                          |  251 --
 drivers/scsi/gdth_proc.c                           |  586 ---
 drivers/scsi/gdth_proc.h                           |   18 -
 drivers/scsi/hpsa.c                                |    4 +-
 drivers/scsi/initio.c                              |   64 +-
 drivers/scsi/initio.h                              |   25 -
 drivers/scsi/ips.c                                 |    9 +-
 drivers/scsi/mac53c94.c                            |    1 -
 drivers/scsi/megaraid.c                            |    6 +-
 drivers/scsi/megaraid/megaraid_mbox.c              |    8 +-
 drivers/scsi/ncr53c8xx.c                           |   83 +-
 drivers/scsi/ncr53c8xx.h                           |   16 -
 drivers/scsi/nsp32.c                               |    2 +-
 drivers/scsi/pcmcia/nsp_cs.c                       |   12 +-
 drivers/scsi/pcmcia/nsp_cs.h                       |   11 -
 drivers/scsi/qla2xxx/qla_os.c                      |    2 +-
 drivers/scsi/qla4xxx/ql4_fw.h                      |    1 -
 drivers/scsi/qla4xxx/ql4_isr.c                     |    2 +-
 drivers/scsi/scsi_debug.c                          |    2 +-
 drivers/scsi/stex.c                                |   25 +-
 drivers/scsi/storvsc_drv.c                         |    2 +-
 drivers/scsi/ufs/ufshcd.c                          |    4 +-
 drivers/scsi/wd33c93.c                             |    6 +-
 include/scsi/scsi.h                                |    1 +
 include/scsi/scsi_cmnd.h                           |    5 +
 66 files changed, 1353 insertions(+), 7728 deletions(-)
 delete mode 100644 drivers/scsi/gdth.c
 delete mode 100644 drivers/scsi/gdth.h
 delete mode 100644 drivers/scsi/gdth_ioctl.h
 delete mode 100644 drivers/scsi/gdth_proc.c
 delete mode 100644 drivers/scsi/gdth_proc.h

-- 
2.16.4

