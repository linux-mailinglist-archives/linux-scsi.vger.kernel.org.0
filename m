Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74029520A9
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Jun 2019 04:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbfFYCd1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Jun 2019 22:33:27 -0400
Received: from m12-12.163.com ([220.181.12.12]:37270 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbfFYCd0 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 24 Jun 2019 22:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=lAONc
        5PtMxKToIAGu8XShVayG56eoMSu8q+iXj2bFJk=; b=MrD9KKBJlOYRs98KLWg4Z
        CsYStNI1t7K8UEk4J07GwzW2Gs4CfhAMv16ixa88MQwT1AHWxxK7Iro5SLU4AWu/
        QGdoV4SMPljWpi+WnFtttu9Y5RwtWi3sQhnOhhWwOExj9r7DoHgAeFD7tzFd21iI
        T4dtaNmR3Z/65cQgphvabk=
Received: from tero-machine (unknown [116.117.135.205])
        by smtp8 (Coremail) with SMTP id DMCowACXNtvihxFdcytVBA--.22033S3;
        Tue, 25 Jun 2019 10:33:10 +0800 (CST)
Date:   Tue, 25 Jun 2019 10:33:04 +0800
From:   Lin Yi <teroincn@163.com>
To:     QLogic-Storage-Upstream@qlogic.com, skashyap@marvell.com
Cc:     linux-scsi@vger.kernel.org
Subject: [PATCH v2 0/2] Fix struct bnx2fc_cmd refcount imbalance in several
 functions
Message-ID: <cover.1561429511.git.teroincn@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CM-TRANSID: DMCowACXNtvihxFdcytVBA--.22033S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUatCzDUUUU
X-Originating-IP: [116.117.135.205]
X-CM-SenderInfo: 5whu0xxqfqqiywtou0bp/1tbiERHeElWBnJT7bwAAsE
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

in bnx2fc_send_rec and bnx2fc_send_srr, it calls the separate kref_put on err handle path, we can't release refcount before taking it's refcount, so avoid calling it inthe err path.

Lin Yi (2):
  scsi :bnx2fc :bnx2fc_els :fix bnx2fc_cmd refcount imbalance in
    send_rec
  scsi :bnx2fc :bnx2fc_els :fix bnx2fc_cmd refcount imbalance in
    send_srr

 drivers/scsi/bnx2fc/bnx2fc_els.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
1.9.1


