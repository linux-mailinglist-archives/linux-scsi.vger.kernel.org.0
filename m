Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81BF2C1CC8
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Nov 2020 05:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgKXEgJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 23 Nov 2020 23:36:09 -0500
Received: from smtprelay0002.hostedemail.com ([216.40.44.2]:59166 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726039AbgKXEgJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 23 Nov 2020 23:36:09 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id E33CA180A8CB9;
        Tue, 24 Nov 2020 04:36:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:541:973:988:989:1260:1311:1314:1345:1437:1515:1534:1538:1561:1711:1714:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3865:3867:3868:5007:6261:10004:10848:11658:11914:12043:12297:12679:12683:12895:13069:13311:13357:13894:14110:14384:14394:21080:21433:21451:21627:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: slave81_4a164e22736b
X-Filterd-Recvd-Size: 1103
Received: from joe-laptop.perches.com (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 24 Nov 2020 04:36:06 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-scsi@vger.kernel.org
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] scsi: pm8001: Further neatening and whitespace
Date:   Mon, 23 Nov 2020 20:36:02 -0800
Message-Id: <cover.1606192458.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Make the logging macro uses clearer and fix a whitespace defect.

Joe Perches (2):
  scsi: pm8001: Convert pm8001_printk to pm8001_info
  scsi: pm8001: Fix misindentation

 drivers/scsi/pm8001/pm8001_init.c | 32 +++++++++++++++----------------
 drivers/scsi/pm8001/pm8001_sas.c  |  4 ++--
 drivers/scsi/pm8001/pm8001_sas.h  |  4 ++--
 3 files changed, 20 insertions(+), 20 deletions(-)

-- 
2.26.0

