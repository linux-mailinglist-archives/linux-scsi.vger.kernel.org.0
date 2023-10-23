Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE897D2DD1
	for <lists+linux-scsi@lfdr.de>; Mon, 23 Oct 2023 11:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjJWJPT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 23 Oct 2023 05:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjJWJPP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 23 Oct 2023 05:15:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33A398
        for <linux-scsi@vger.kernel.org>; Mon, 23 Oct 2023 02:15:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3655E1FE0C;
        Mon, 23 Oct 2023 09:15:11 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id AF1D62C7D1;
        Mon, 23 Oct 2023 09:15:10 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id DA1AA51EC31F; Mon, 23 Oct 2023 11:15:10 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv8 00/16] scsi: EH rework prep patches, part 2
Date:   Mon, 23 Oct 2023 11:14:51 +0200
Message-Id: <20231023091507.120828-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        dmarc=none;
        spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor denied by domain of hare@suse.de) smtp.mailfrom=hare@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [2.49 / 50.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.20)[suse.de];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.60)[~all:c];
         RCPT_COUNT_FIVE(0.00)[5];
         TO_MATCH_ENVRCPT_SOME(0.00)[];
         VIOLATED_DIRECT_SPF(3.50)[];
         MX_GOOD(-0.01)[];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 2.49
X-Rspamd-Queue-Id: 3655E1FE0C
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi all,

(taking up an old thread:)
here's the second batch of patches for my EH rework.
It modifies the reset callbacks for SCSI drivers
such that the final conversion to drop the 'struct scsi_cmnd'
argument and use the entity in question (host, bus, target, device)
as the argument to the SCSI EH callbacks becomes possible.
The second part covers drivers which require a bit more love.
In particular the fnic, snic, and csiostor drivers require a tag to
send TMFs. So to handle that I've set aside a tag and used that directly
(for snic host reset), or call scsi_alloc_request() with the NOWAIT flag.
That will return a scsi command with a valid tag, which then can be used
to send the reset. It might fail (eg when the tagset is full),
but in these cases it might be better to fall back to host_reset anyway.

As usual, comments and reviews are welcome.

Changes to v7:
- Include reviews from Bart
- Change return value to DID_TRANSPORT_FAILFAST

Changes to v6:
- Include reviews from Christoph
- Add missing kerneldoc updates

Changes to v5:
- Modified zfcp host reset to return FAST_IO_FAIL
- Rebased to 6.7/staging
- Add fix for missing scsi_device_put() in pmcraid
- Modify doing_srb_done() in dc395x to not use a scsi command

Changes to v4:
- rework snic to use a dedicated tag for host reset
- rework snic to allocate TMFs on the fly
- rework fnic to allocate TMFs on the fly
- rework csiostor to allocat TMFs on the fly
- drop fc_block_rport() from zfcp host_reset
- Rebase to latest linus tree

Changes to v3:
- Move fnic and snic patches to the next patchset
- Include reviews from Ewan Milne

Changes to v2:
- Include reviews from John Garry
- move mpi3mr, zfcp, sym53c8xx_2, and qla1280 patches to the
  next patchset

Changes to the initial version:
- Include reviews from Christoph
- Fixup build robot issues

Hannes Reinecke (16):
  zfcp: do not wait for rports to become unblocked after host reset
  bfa: Do not use scsi command to signal TMF status
  aha152x: look for stuck command when resetting device
  a1000u2w: do not rely on the command for inia100_device_reset()
  fas216: Rework device reset to not rely on SCSI command pointer
  xen-scsifront: add scsi device as argument to scsifront_do_request()
  xen-scsifront: rework scsifront_action_handler()
  libiscsi: use cls_session as argument for target and session reset
  scsi_transport_iscsi: use session as argument for
    iscsi_block_scsi_eh()
  snic: reserve tag for TMF
  snic: allocate device reset command
  snic: Use scsi_host_busy_iter() to traverse commands
  fnic: allocate device reset command on the fly
  fnic: use fc_block_rport() correctly
  csiostor: use separate TMF command
  dc395x: Remove 'scmd' parameter from doing_srb_done()

 drivers/s390/scsi/zfcp_scsi.c       |   6 +-
 drivers/scsi/a100u2w.c              |  46 +---
 drivers/scsi/aha152x.c              |  26 ++-
 drivers/scsi/arm/fas216.c           |  39 ++--
 drivers/scsi/be2iscsi/be_main.c     |  10 +-
 drivers/scsi/bfa/bfad_im.c          | 112 +++++-----
 drivers/scsi/bfa/bfad_im.h          |   2 +
 drivers/scsi/csiostor/csio_scsi.c   |  72 ++++--
 drivers/scsi/dc395x.c               |  14 +-
 drivers/scsi/fnic/fnic.h            |   1 -
 drivers/scsi/fnic/fnic_scsi.c       | 120 +++++-----
 drivers/scsi/libiscsi.c             |  25 +--
 drivers/scsi/qla4xxx/ql4_os.c       |  34 +--
 drivers/scsi/scsi_transport_iscsi.c |   6 +-
 drivers/scsi/snic/snic.h            |   2 +-
 drivers/scsi/snic/snic_main.c       |   5 +-
 drivers/scsi/snic/snic_scsi.c       | 328 ++++++++++++----------------
 drivers/scsi/xen-scsifront.c        |  50 +++--
 include/scsi/libiscsi.h             |   2 +-
 include/scsi/scsi_transport_iscsi.h |   2 +-
 20 files changed, 441 insertions(+), 461 deletions(-)

-- 
2.35.3

