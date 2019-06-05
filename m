Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C207357F9
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Jun 2019 09:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfFEHjw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 5 Jun 2019 03:39:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:43074 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726341AbfFEHjw (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 5 Jun 2019 03:39:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EB220AFC7;
        Wed,  5 Jun 2019 07:39:50 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/4] libfc,fcoe: cleanup fc_rport_priv usage
Date:   Wed,  5 Jun 2019 09:39:38 +0200
Message-Id: <20190605073942.125577-1-hare@suse.de>
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
This patchset also contains some minor cleanups to the libfc code, fixing
up whitespaces and dropping an unused callback.

As usual, comments and reviews are welcome.

Hannes Reinecke (4):
  libfc: kill lld_event_callback
  libfc: Whitespqce cleanup in libfc.h
  fcoe: avoid memset across pointer boundaries
  fcoe: pass in fcoe_rport structure instead of fc_rport_priv

 drivers/scsi/fcoe/fcoe_ctlr.c | 140 ++++++++++++++++++++----------------------
 drivers/scsi/libfc/fc_rport.c |  18 +++---
 include/scsi/libfc.h          |  55 ++++++++---------
 include/scsi/libfcoe.h        |   1 +
 4 files changed, 104 insertions(+), 110 deletions(-)

-- 
2.16.4

