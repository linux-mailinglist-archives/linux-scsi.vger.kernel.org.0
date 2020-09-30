Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6789227E335
	for <lists+linux-scsi@lfdr.de>; Wed, 30 Sep 2020 10:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgI3IDC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 30 Sep 2020 04:03:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:60954 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgI3IDC (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 30 Sep 2020 04:03:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6AB27AB0E;
        Wed, 30 Sep 2020 08:03:01 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/4] scsi: remove devices in ALUA transitioning status
Date:   Wed, 30 Sep 2020 10:02:52 +0200
Message-Id: <20200930080256.90964-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi all,

during testing we found that there is an issue with dev_loss_tmo and
devices in ALUA transitioning state.
What happens is that I/O gets requeued via BLK_STS_RESOURCE for these
devices, so when dev_loss_tmo triggers the SCSI core cannot flush the
request list as I/O is simply requeued.

So when the driver is trying to re-establish the device it'll wait for
that last reference to drop in order to re-attach the device, but as I/O
is still outstanding on the (old) device it'll wait for ever.

Fix this by returning 'BLK_STS_AGAIN' from scsi_dh_alua when the device
is in ALUA transitioning, and also set the 'transitioning' state when
scsi_dh_alua is receiving a sense code, and not only after scsi_dh_alua
successfully received the response to a REPORT TARGET PORT GROUPS
command.

Hannes Reinecke (4):
  block: return status code in blk_mq_end_request()
  scsi_dh_alua: return BLK_STS_AGAIN for ALUA transitioning state
  scsi_dh_alua: set 'transitioning' state on unit attention
  scsi: return BLK_STS_AGAIN for ALUA transitioning

 block/blk-mq.c                             |  2 +-
 drivers/scsi/device_handler/scsi_dh_alua.c | 10 +++++++++-
 drivers/scsi/scsi_lib.c                    |  8 ++++++++
 3 files changed, 18 insertions(+), 2 deletions(-)

-- 
2.16.4

