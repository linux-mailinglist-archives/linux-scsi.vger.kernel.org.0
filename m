Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 488C672AF2
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Jul 2019 11:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfGXJBN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 24 Jul 2019 05:01:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:55388 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726070AbfGXJBN (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 24 Jul 2019 05:01:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3E1FFAFBD;
        Wed, 24 Jul 2019 09:01:12 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv3 0/3] fcoe: cleanup fc_rport_priv usage
Date:   Wed, 24 Jul 2019 11:00:53 +0200
Message-Id: <20190724090056.7506-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi all,

the fcoe vn2vn code is using the 'fc_rport_priv' structure as argument to its
internal function, but is really expecting a struct fcoe_rport to immediately
follow this one. This is not only confusing but also an error for new compilers.
So clean up the usage by embedding fc_rport_priv into fcoe_rport, and use the
fcoe_rport structure wherever possible.
This patchset also contains some minor whitespace cleanups for libfc.h.

As usual, comments and reviews are welcome.

Changes to v1:
- Drop patch to remove lld_event_callback

Changes to v2:
- Include reviews from Christoph

Hannes Reinecke (3):
  libfc: Whitespqce cleanup in libfc.h
  fcoe: Embed fc_rport_priv in fcoe_rport structure
  fcoe: pass in fcoe_rport structure instead of fc_rport_priv

 drivers/scsi/fcoe/fcoe_ctlr.c | 138 ++++++++++++++++++++----------------------
 drivers/scsi/libfc/fc_rport.c |   5 +-
 include/scsi/libfc.h          |  52 ++++++++--------
 include/scsi/libfcoe.h        |   1 +
 4 files changed, 96 insertions(+), 100 deletions(-)

-- 
2.16.4

