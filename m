Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0EC52BB9D4
	for <lists+linux-scsi@lfdr.de>; Sat, 21 Nov 2020 00:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbgKTXQU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 20 Nov 2020 18:16:20 -0500
Received: from smtprelay0167.hostedemail.com ([216.40.44.167]:39770 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726719AbgKTXQT (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 20 Nov 2020 18:16:19 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id D69A7837F24D;
        Fri, 20 Nov 2020 23:16:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:541:988:989:1260:1311:1314:1345:1437:1515:1534:1539:1567:1711:1714:1730:1747:1777:1792:1981:2194:2199:2393:2559:2562:3138:3139:3140:3141:3142:3866:3868:3870:5007:6261:10004:10848:11658:11914:12043:12297:12679:12895:13069:13311:13357:13894:14384:14394:21080:21451:21611:21627:30012:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: pull06_5d1058b2734f
X-Filterd-Recvd-Size: 1327
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Fri, 20 Nov 2020 23:16:16 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-scsi@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] scsi: pm8001: logging neatening
Date:   Fri, 20 Nov 2020 15:16:08 -0800
Message-Id: <cover.1605914030.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Reduce code duplication and generic neatening of logging macros

Joe Perches (2):
  scsi: pm8001: Neaten debug logging macros and uses
  scsi: pm8001: Make implicit use of pm8001_ha in pm8001_printk explicit

 drivers/scsi/pm8001/pm8001_ctl.c  |    7 +-
 drivers/scsi/pm8001/pm8001_hwi.c  | 1370 ++++++++++---------------
 drivers/scsi/pm8001/pm8001_init.c |  102 +-
 drivers/scsi/pm8001/pm8001_sas.c  |  136 ++-
 drivers/scsi/pm8001/pm8001_sas.h  |   45 +-
 drivers/scsi/pm8001/pm80xx_hwi.c  | 1596 ++++++++++++-----------------
 6 files changed, 1361 insertions(+), 1895 deletions(-)

-- 
2.26.0

