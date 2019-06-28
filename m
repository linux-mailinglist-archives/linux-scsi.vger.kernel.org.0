Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B19A59426
	for <lists+linux-scsi@lfdr.de>; Fri, 28 Jun 2019 08:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfF1GW6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 28 Jun 2019 02:22:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48534 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfF1GW6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 28 Jun 2019 02:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yaxzBZoKG5uqgp2Dc+YmYOZs72ahmoev192Hb8KX5XA=; b=DSMJP/7B3YCHbac+Hz0PDdWNXX
        iJrIowzl5Bx/tkQn1wtJpkJKOfh0qc5ZYosYO0AMBbBLqZoDZHDABfgSU7QKZha+MATBc1ZV2AETj
        7UnMQgps2dGBHaVc5k54e1n+j1AYEdJ1SY3TN2avsVQqsDqTjuSleXf/XdyJGNrdFib641Nc4Ifw3
        DtUuWcKeRsD+6UL7mqwXMvq3TP9x6brSz+NleUc9sxZLCumi0g0P193EEJxcptvYDZTMS1whKmXa4
        10lI6HFGtvJpYV97y7CQXJd2/GFJEHZTd20SCfAPY6iHKLxHX9kaoY5TyHJDfoKuY+WYJ5DRiD715
        +PxnB4dg==;
Received: from 089144214055.atnat0023.highway.a1.net ([89.144.214.55] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgkHh-0000dy-Cs
        for linux-scsi@vger.kernel.org; Fri, 28 Jun 2019 06:22:57 +0000
Date:   Fri, 28 Jun 2019 08:22:55 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     linux-scsi@vger.kernel.org
Subject: [ANNOUNCE] Alpine Linux Persistence and Storage Summit
Message-ID: <20190628062255.GC2014@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

We proudly announce the second Alpine Linux Persistence and Storage
Summit (ALPSS), which will be held October 1st to October 4th 2019 at
the Lizumerhuette [1][2] in Austria .

The goal of this conference is to discuss the hot topics in Linux storage
and file systems, such as persistent memory, NVMe, Zoned Block Device,
and PCIe peer to peer transfers in a cool and relaxed setting with
spectacular views in the Austrian alps.

We plan to have a small selection of short and to the point talks with
lots of room for discussion in small groups, as well as ample downtime
to enjoy the surrounding.

Attendance is free except for the accommodation and food at the lodge [3],
but the number of seats is strictly limited.  If you are interested in
attending please reserve a seat by mailing your favorite topic(s) to:

	alpss-pc@lists.infradead.org

If you are interested in giving a short and crisp talk please also send
an abstract to the same address.

Note: The Lizumerhuette is an Alpine Society lodge in a high alpine
environment.  A hike of approximately 2 hours is required to the lodge,
and no other accommodations are available within walking distance.

More details will eventually be available on our website:

        http://www.alpss.at/

Thank you on behalf of the program committee:

    Stephen Bates
    Sagi Grimberg
    Christoph Hellwig
    Johannes Thumshirn
    Richard Weinberger

[1] http://www.tyrol.com/things-to-do/sports/hiking/refuge-huts/a-lizumer-hut
[2] https://www.glungezer.at/l-i-z-u-m-e-r-h-%C3%BC-t-t-e/
[3] approx. EUR 40-60 per person and night, depending on the room
    category
