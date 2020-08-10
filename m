Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E99BD241376
	for <lists+linux-scsi@lfdr.de>; Tue, 11 Aug 2020 00:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgHJW71 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 10 Aug 2020 18:59:27 -0400
Received: from smtprelay0192.hostedemail.com ([216.40.44.192]:56836 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726634AbgHJW70 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 10 Aug 2020 18:59:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id E4A2D4DBD;
        Mon, 10 Aug 2020 22:59:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:541:973:988:989:1260:1311:1314:1345:1437:1515:1534:1541:1711:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3352:3865:3867:3868:4605:5007:6261:7807:8603:10007:10848:11658:11914:12043:12291:12297:12555:12679:12683:12895:13069:13161:13229:13311:13357:13894:14096:14384:14394:14721:21080:21451:21627:21810:30012:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:1:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: way77_1f01da226fde
X-Filterd-Recvd-Size: 1917
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Mon, 10 Aug 2020 22:59:24 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] scsi: lpfc: Reduce logging object code size
Date:   Mon, 10 Aug 2020 15:59:18 -0700
Message-Id: <cover.1597100152.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The logging macros are pretty heavyweight and can be consolidated
to reduce overall object size.

Joe Perches (2):
  scsi: lpfc: Neaten logging macro #defines
  scsi: lpfc: Add logging functions to reduce object size

 drivers/scsi/lpfc/Makefile       |   2 +-
 drivers/scsi/lpfc/lpfc.h         |   5 ++
 drivers/scsi/lpfc/lpfc_attr.h    |   5 ++
 drivers/scsi/lpfc/lpfc_bsg.h     |   6 ++
 drivers/scsi/lpfc/lpfc_compat.h  |   5 ++
 drivers/scsi/lpfc/lpfc_crtn.h    |   5 ++
 drivers/scsi/lpfc/lpfc_disc.h    |   5 ++
 drivers/scsi/lpfc/lpfc_hw.h      |   5 ++
 drivers/scsi/lpfc/lpfc_hw4.h     |   5 ++
 drivers/scsi/lpfc/lpfc_ids.h     |   5 ++
 drivers/scsi/lpfc/lpfc_logmsg.c  | 112 +++++++++++++++++++++++++++++++
 drivers/scsi/lpfc/lpfc_logmsg.h  |  63 ++++++-----------
 drivers/scsi/lpfc/lpfc_nl.h      |   4 ++
 drivers/scsi/lpfc/lpfc_nvme.h    |   5 ++
 drivers/scsi/lpfc/lpfc_scsi.h    |   4 ++
 drivers/scsi/lpfc/lpfc_sli.h     |   5 ++
 drivers/scsi/lpfc/lpfc_sli4.h    |   5 ++
 drivers/scsi/lpfc/lpfc_version.h |   5 ++
 18 files changed, 208 insertions(+), 43 deletions(-)
 create mode 100644 drivers/scsi/lpfc/lpfc_logmsg.c

-- 
2.26.0

