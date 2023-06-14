Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC6D72FB1A
	for <lists+linux-scsi@lfdr.de>; Wed, 14 Jun 2023 12:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbjFNKgh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 14 Jun 2023 06:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbjFNKgf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 14 Jun 2023 06:36:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322B41A3;
        Wed, 14 Jun 2023 03:36:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D44AB22493;
        Wed, 14 Jun 2023 10:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686738992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8oMQCRfPm1HxrncWdpZzunTkbWOVMU3+Mv6MzhAp88I=;
        b=CUVMS3YAVutJSAL41APDn28o0a/OKEM4csT7zmlvePsGeTd0+ZbWOI6TUm44WG6vdo5adu
        3gFNJ/jZ7eSMuGYFtplhdqKFH7LC7kEJEaARizYmzReEZu8cyAYjd/Rc+7/TBNtGhFDyps
        hmqzAWI5IkiPyE1jSCps9CqSJm91HLA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 81A911357F;
        Wed, 14 Jun 2023 10:36:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dKjvHTCYiWSTfQAAMHmgww
        (envelope-from <mwilck@suse.com>); Wed, 14 Jun 2023 10:36:32 +0000
From:   mwilck@suse.com
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     James Bottomley <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>, Martin Wilck <mwilck@suse.com>
Subject: [PATCH v7 0/7] scsi: fixes for targets with many LUNs, and scsi_target_block rework
Date:   Wed, 14 Jun 2023 12:36:09 +0200
Message-Id: <20230614103616.31857-1-mwilck@suse.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Martin Wilck <mwilck@suse.com>

This patch series addresses some issues we saw in a test setup
with a large number of SCSI LUNs. The first two patches simply
increase the number of available sg and bsg devices. 3-5 fix
a large delay we encountered between blocking a Fibre Channel
remote port and the dev_loss_tmo. 6 renames scsi_target_block()
to scsi_block_targets(), and makes additional changes to this API,
as suggested in the review of the v2 series. 7 improves a warning message.

Changes v6 -> v7
 - 6/7: fixed mistake I made inverting the argument order in v6
   (I apologize for overlooking this dumb mistake!!)

Changes v5 -> v6
 - 6/7: inverted order of arguments for scsi_block_targets (Christoph Hellwig), dropped "extern"
   (I took the liberty not to remove previous "Reviewed-by"'s because of this change)
 - 5/7: wrapped one over-long comment line
 - added tags

Changes v4 -> v5:
 - added 7/7 to improve the WARN_ON_ONCE in scsi_device_block() (Bart van Assche)
 - 6/7: added WARN_ON_ONCE in scsi_block_targets() (Bart van Assche)
 - 4/7: improved comment (Bart van Assche)
 - Added tags

Changes v3 -> v4:
 - skipped 4/8: keep state_mutex held while quiescing queue (Bart van Assche),
   added a comment in 4/6 to explain the rationale
 - renamed scsi_target_block() to scsi_block_targets() (Christoph Hellwig), and
   merged the previous patches 7/8 and 8/8 modifying this API into 6/6.
 - rebased to latest mkp/queue branch

Changes v2 -> v3:
 - Split previous 3/3 into 4 separate patches as suggested by
   Christoph Hellwig.
 - Added 7/8 and 8/8, as suggested by Christoph and Bart van Assche.
 - Added s-o-b and reviewed-by tags.

Changes v1 -> v2:
 - call blk_mq_wait_quiesce_done() from scsi_target_block() to
   cover the case where BLK_MQ_F_BLOCKING is set (Bart van Assche)

Hannes Reinecke (2):
  bsg: increase number of devices
  scsi: sg: increase number of devices

Martin Wilck (5):
  scsi: merge scsi_internal_device_block() and device_block()
  scsi: don't wait for quiesce in scsi_stop_queue()
  scsi: don't wait for quiesce in scsi_device_block()
  scsi: replace scsi_target_block() by scsi_block_targets()
  scsi: improve warning message in scsi_device_block()

 block/bsg.c                         |  2 +-
 drivers/scsi/scsi_lib.c             | 80 ++++++++++++++---------------
 drivers/scsi/scsi_transport_fc.c    |  2 +-
 drivers/scsi/scsi_transport_iscsi.c |  3 +-
 drivers/scsi/scsi_transport_srp.c   |  6 +--
 drivers/scsi/sg.c                   |  2 +-
 drivers/scsi/snic/snic_disc.c       |  2 +-
 include/scsi/scsi_device.h          |  2 +-
 8 files changed, 50 insertions(+), 49 deletions(-)

-- 
2.40.1

