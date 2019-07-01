Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E52F10B31
	for <lists+linux-scsi@lfdr.de>; Wed,  1 May 2019 18:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfEAQRZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 1 May 2019 12:17:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47960 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfEAQPI (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 1 May 2019 12:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oHHHJivNn10YJ/v35o0sJeDAixlW7bD20a8kHdNA8hk=; b=L4vA6rGlGxKYeF74RID1ySE4f
        y78oTIPAh14bbqyXUGAHgyifKCqOx8VESZp7u8eMideIkURA8pMRRaPVDwB32Km1ZNYZzZ/Ho6uAa
        KMHAa3tHwPEIUXzaXL0pmApLs0B1NPBZTqWv0PUlEWs+Yw6sPdTmAJMbqIHlFtNRxDAO+p5AsYbqX
        rZuLOgwK3qMzD+k7KMCZ6/8GH5Uh3p1sHES3SoF38TK8OUZVYXN7IB4LFRrhgeAZRUhkwIvPFWeL4
        zKJhqEBY58MisJquyzWLgD8ZA8sjrYNB8novPak6DcUS2a3GfP+S3/EohjkdINDYyDQ1cX7w1oE2/
        AmW7GUeOg==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLrsk-0004OI-NS; Wed, 01 May 2019 16:14:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Hannes Reinecke <hare@suse.de>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>, Willem Riede <osst@riede.org>,
        Doug Gilbert <dgilbert@interlog.com>,
        Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-scsi@vger.kernel.org, open-iscsi@googlegroups.com,
        osst-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: switch core SCSI code to SPDX tags
Date:   Wed,  1 May 2019 12:13:53 -0400
Message-Id: <20190501161417.32592-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi all,

this series switches all SCSI midlayer, upper driver, transport class and
library files to have proper SPDX tags instead of no licensing information
or copy and pasted boilerplate code.
