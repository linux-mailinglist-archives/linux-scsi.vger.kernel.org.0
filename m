Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6369F4F972
	for <lists+linux-scsi@lfdr.de>; Sun, 23 Jun 2019 03:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfFWB4Z (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 22 Jun 2019 21:56:25 -0400
Received: from m12-11.163.com ([220.181.12.11]:36620 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbfFWB4Z (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 22 Jun 2019 21:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=BeE6U
        MetSPgtROcsEd0rO69Q6hGWhitBUBHwIDajC50=; b=aUhmHRVjyjTV0eDi/ClN2
        O9Of6UUeOfolnZ/UE57jjzmPkQUX1QO/fdBeMXyPE63tI0vr2BNQVcxS/y7GlYIt
        i5FRblrm0wnzpT02L9/WDSGqDbryOPRQRpAxWGUXJO61yLRXXROR38fDvDnfiRFu
        AX/GOgc6u9GJoVJucxTXmA=
Received: from tero-machine (unknown [124.16.84.178])
        by smtp7 (Coremail) with SMTP id C8CowAA3u8w83A5d5A7tBA--.40452S3;
        Sun, 23 Jun 2019 09:56:12 +0800 (CST)
Date:   Sun, 23 Jun 2019 09:56:11 +0800
From:   Lin Yi <teroincn@163.com>
To:     QLogic-Storage-Upstream@qlogic.com
Cc:     linux-scsi@vger.kernel.org, csong@cs.ucr.edu, liujian6@iie.ac.cn,
        zhiyunq@cs.ucr.edu, yiqiuping@gmail.com, teroincn@163.com
Subject: [PATCH 0/2] Fix struct bnx2fc_cmd refcount imbalance in different
 functions
Message-ID: <cover.1561254730.git.teroincn@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CM-TRANSID: C8CowAA3u8w83A5d5A7tBA--.40452S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU2yCGUUUUU
X-Originating-IP: [124.16.84.178]
X-CM-SenderInfo: 5whu0xxqfqqiywtou0bp/1tbiwBzcElXllxO18gAAsh
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

*** BLURB HERE ***

Lin Yi (2):
  scsi :bnx2fc :bnx2fc_els :fix bnx2fc_cmd refcount imbalance in
    send_rec
  scsi :bnx2fc :bnx2fc_els :fix bnx2fc_cmd refcount imbalance in
    send_srr

 drivers/scsi/bnx2fc/bnx2fc_els.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
1.9.1


