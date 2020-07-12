Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A8C21CAF0
	for <lists+linux-scsi@lfdr.de>; Sun, 12 Jul 2020 20:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgGLS3h (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 12 Jul 2020 14:29:37 -0400
Received: from smtp.infotech.no ([82.134.31.41]:50597 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729104AbgGLS3h (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 12 Jul 2020 14:29:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 7B0A7204255;
        Sun, 12 Jul 2020 20:29:35 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 74jjYyN7puPu; Sun, 12 Jul 2020 20:29:30 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-78-251-166.dyn.295.ca [45.78.251.166])
        by smtp.infotech.no (Postfix) with ESMTPA id 35351204164;
        Sun, 12 Jul 2020 20:29:28 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de
Subject: [PATCH 0/2] scsi_debug: every_nth cleanup, url + version
Date:   Sun, 12 Jul 2020 14:29:25 -0400
Message-Id: <20200712182927.72044-1-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

It was becoming hard to follow exactly when to expect the error
injection facilities in this driver to fire. Sometimes injected
errors just didn't seem to happen.

The error injection design was too complicated for what was
required. Simplify it and make it more consistent. The second
patch in this set does some housekeeping.

Douglas Gilbert (2):
  scsi_debug: every_nth triggered error injection
  scsi_debug: update documentation url and bump version

 drivers/scsi/scsi_debug.c | 237 +++++++++++++++++---------------------
 1 file changed, 104 insertions(+), 133 deletions(-)

-- 
2.25.1

