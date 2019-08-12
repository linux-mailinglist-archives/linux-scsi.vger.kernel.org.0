Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81FBE8A0DE
	for <lists+linux-scsi@lfdr.de>; Mon, 12 Aug 2019 16:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfHLOWj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 12 Aug 2019 10:22:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41564 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfHLOWh (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 12 Aug 2019 10:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jRnkrfaguvLGc+5UAYQVpJFqMlzCjuqQT6gNDn/Eyww=; b=jjOROmgV1h5B3sPt40sQ4orGH
        VOJ9fyRhAtiFTCf4t8kZ7LzH1pR6JNtJwJHXbiwckL9kbL0RKtF7wEqYf0ieIklMPeewQ6El89Yrt
        7mc/7/1sMWr2yFgC14GUpnfhjAGdCMX4vWUO2vuWKzkFrIwzu3BUTGJ5ddL3DD7k4lzFgOGy2fjsN
        +rlEApN9DM7SgPMl3IVWG5VIlORNNpdB04Db+uIe19+cUccZJGuH8iUHYGx83a0jEg+Fdwj3/f/HE
        uRnQV/TKBhVczEYx3jDhy7lor2ajoeJskyrIG/ZEInZhAYyLiHSne1oqPaFXxPW+c52e7L5nCxLA9
        Q/4leBWKQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxBDY-0002SJ-TL; Mon, 12 Aug 2019 14:22:37 +0000
Date:   Mon, 12 Aug 2019 07:22:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com, hare@suse.de, bvanassche@acm.org
Subject: Re: [PATCH v3 02/20] sg: remove typedefs, type+formatting cleanup
Message-ID: <20190812142236.GB8105@infradead.org>
References: <20190807114252.2565-1-dgilbert@interlog.com>
 <20190807114252.2565-3-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807114252.2565-3-dgilbert@interlog.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Aug 07, 2019 at 01:42:34PM +0200, Douglas Gilbert wrote:
> Typedefs for structure types are discouraged so those structures
> that are private to the driver have had their typedefs removed.
> 
> This also means that most "camel" type variable names (i.e. mixed
> case) have been removed.
> 
> Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
