Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 009FA163756
	for <lists+linux-scsi@lfdr.de>; Wed, 19 Feb 2020 00:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgBRXiN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Feb 2020 18:38:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45042 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgBRXiN (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 18 Feb 2020 18:38:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JL/PP/KAUGdmRPebh+7aDGyrZyp2+++sZ9CdQ4ublpc=; b=ukdV/DGazHf0i6iEwSFgS5p2Yx
        DDA6RuaKrredF98BeFgizhMoBH0ELOxsxznRpCgqUvZ6xJspKOq+aZ1zYmwFh5XUAPuvRPhO3aELC
        0p/RexG+4Ph1l4mD1SJ/yF50LZHLlEe7pOMVvqB18XYSEM+Xm0UJ5NbF+lSarfgwUZQkloqc07mGM
        4nd7Kc5pbZ16N8zbPTv/Bj17YgWH7J0P0GI/I2Mfq+DLRkNv2nFZfhmFRrIpIeqzzw64Le/RVoF8c
        OOCzG0qUXcTB2zwQsBgXPXM+j2XAokL7dAkNF2RFmVykjW2nH8ODw7hH56n7pd20A+gaeb7LEBufV
        myj9HwFQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4CRQ-0003TQ-AQ; Tue, 18 Feb 2020 23:38:12 +0000
Date:   Tue, 18 Feb 2020 15:38:12 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Kiwoong Kim <kwmad.kim@samsung.com>
Cc:     linux-scsi@vger.kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Subject: Re: [PATCH] ufs: fix a bug on printing PRDT
Message-ID: <20200218233812.GB6827@infradead.org>
References: <CGME20200218233124epcas2p3888d2788d42af542cde915df4c4baf23@epcas2p3.samsung.com>
 <20200218233115.8185-1-kwmad.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218233115.8185-1-kwmad.kim@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Feb 19, 2020 at 08:31:15AM +0900, Kiwoong Kim wrote:
> In some architectures, an unit of PRDTO and PRDTL
> in UFSHCI spec assume bytes, not double word specified
> in the spec. W/o this patch, when the driver executes
> this, kernel panic occurres because of abnormal accesses.

This quirk doesn't have any driver actually setting it, so we need
to remove it.
