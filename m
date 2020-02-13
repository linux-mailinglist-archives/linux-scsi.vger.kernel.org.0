Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF5715C27D
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Feb 2020 16:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgBMPcL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 13 Feb 2020 10:32:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:37678 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388139AbgBMPcK (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 13 Feb 2020 10:32:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1DEE7B150;
        Thu, 13 Feb 2020 15:32:09 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart van Assche <bvanassche@acm.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv2 0/3] ch: fixup refcounting imbalance for SCSI devices
Date:   Thu, 13 Feb 2020 16:32:04 +0100
Message-Id: <20200213153207.123357-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi all,

here's a set of fixes for a long-standing issue in the 'ch' driver
where we would crash if one of the referenced devices was removed
from underneath us.

As usual, comments and reviews are welcome.

Changes to v1:
- Reworked after reviews from Bart

Hannes Reinecke (3):
  ch: fixup refcounting imbalance for SCSI devices
  ch: synchronize ch_probe() and ch_open()
  ch: remove ch_mutex()

 drivers/scsi/ch.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

-- 
2.16.4

