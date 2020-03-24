Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2215819087D
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Mar 2020 10:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgCXJG5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 24 Mar 2020 05:06:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44046 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgCXJG5 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 24 Mar 2020 05:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xaQk5zFlZzKZuPMAqkJ7UDASuZcToMtFEgavqSMOCMM=; b=Iz4bNZryDPwuf8KH0Qdtn3zvJE
        Fvt2QxDYUcm1QF/vmK06PgrEmZpqJ0+ipJNzdiOmtK/Bb8udz5MGJblBLNBv2BhCpz8uFfFrgqzBg
        KRxytbSHth4j2+9fP/RDwki/sTXH52lJj4k1TJMdDylwLz0cRioLPNa/yYDwIF4RX+LmSLnq6k2YQ
        mjmOfk2Eu/zEsl0gxHCn5TwqIPOCi7i+iu0hIRzn9xBQlal/TQHaOQBG4l2M3IKjtY0nWt7I0V32A
        E3OQSW5gwsA/0KkkJGSUTza7VyHRY6/NiFrUSrkmN5Z4euCFqS/Wh4F4eGtQ5IGN8jbKnhSvLS1uG
        nF/qoiFg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGfWS-0005Dp-UW; Tue, 24 Mar 2020 09:06:56 +0000
Date:   Tue, 24 Mar 2020 02:06:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Disseldorp <ddiss@suse.de>
Cc:     target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, bvanassche@acm.org
Subject: Re: [RFC PATCH 1/5] scsi: target: use #def for xcopy descriptor len
Message-ID: <20200324090656.GA18399@infradead.org>
References: <20200323165410.24423-1-ddiss@suse.de>
 <20200323165410.24423-2-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323165410.24423-2-ddiss@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Mar 23, 2020 at 05:54:06PM +0100, David Disseldorp wrote:
> Signed-off-by: David Disseldorp <ddiss@suse.de>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
