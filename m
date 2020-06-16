Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11FC1FB031
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2020 14:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgFPMSf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 16 Jun 2020 08:18:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:37472 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728713AbgFPMSa (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 16 Jun 2020 08:18:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 38287ADCD;
        Tue, 16 Jun 2020 12:18:33 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/4] gdth: bring driver into this century
Date:   Tue, 16 Jun 2020 14:18:17 +0200
Message-Id: <20200616121821.99113-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi all,

the gdth driver has long seen no updates, and has a very peculiar
coding style.
Here's an attempt to (slowly) move it towards the linux coding style,
and fixup some oddities within the driver itself.

Adaptec has been defunct for several years now, so I doubt the maintainer
address is still working; so I'll leave it out for now.
Achim, if you are still around, do speak up :-)

As usual, comments and reviews are welcome.

Hannes Reinecke (4):
  gdth: reindent and whitespace cleanup
  gdth: do not use struct scsi_cmnd as argument for bus reset
  gdth: kill __gdth_execute()
  gdth: stop abusing ->request pointer for completion

 drivers/scsi/gdth.c       | 6520 ++++++++++++++++++++++-----------------------
 drivers/scsi/gdth.h       | 1377 +++++-----
 drivers/scsi/gdth_ioctl.h |  378 +--
 drivers/scsi/gdth_proc.c  | 1109 ++++----
 drivers/scsi/gdth_proc.h  |    8 +-
 5 files changed, 4695 insertions(+), 4697 deletions(-)

-- 
2.16.4

