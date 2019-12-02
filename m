Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29D1810EECA
	for <lists+linux-scsi@lfdr.de>; Mon,  2 Dec 2019 18:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfLBRxn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 2 Dec 2019 12:53:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59924 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbfLBRxn (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 2 Dec 2019 12:53:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M7fv7jcOHqgohkKt6f3sn6tPoUKwQcA0o8iBf5ScMR0=; b=Ftn3CX6v4yGsyPyCd7AAhMAhq
        I1vzf9YcNLjMrtrHPnqfxpK/QaVDWE2JBG3KrM+sLCo/J4E3friVmXTXfOGtZmI6HZ8becZ87M4Pv
        g6D4jmcjz30PIB288ApHnafM8k434QwrcjYLOvFwAmlxUAgak0ZDOqORuiGRC1PhCbcRrUlBXuE1T
        1l22YEvFDxqeSIVr63exXLm4cHJXWTmuSBCrOJDmUgWunFeFYVJ+Rsu2MVYxnDdVDZTJsf2WlMiRI
        2tBLpLubYolQHogMga4ed/rdcncw76uYQs9xx8+x44Y140TO5qN5TrJjHXE9+2qJ8bK9WEtRzypx0
        wRSsIt9Xw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ibptF-00033n-Kt; Mon, 02 Dec 2019 17:53:41 +0000
Date:   Mon, 2 Dec 2019 09:53:41 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Can Guo <cang@codeaurora.org>
Cc:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        rnayak@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>,
        Evan Green <evgreen@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: ufs: Give an unique ID to each ufs-bsg
Message-ID: <20191202175341.GA11646@infradead.org>
References: <0101016ec4a25ed1-faa62196-1f0c-48a8-9cba-a433245d0ed0-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0101016ec4a25ed1-faa62196-1f0c-48a8-9cba-a433245d0ed0-000000@us-west-2.amazonses.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Dec 02, 2019 at 03:23:25AM +0000, Can Guo wrote:
> Considering there can be multiple UFS hosts in SoC, give each ufs-bsg an
> unique ID by appending the scsi host number to its device name.
> 
> Signed-off-by: Can Guo <cang@codeaurora.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

This should also get a Fixes: tag so that it gets backported.
