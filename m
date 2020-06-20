Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836B2202225
	for <lists+linux-scsi@lfdr.de>; Sat, 20 Jun 2020 09:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgFTHNG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 20 Jun 2020 03:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgFTHNF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 20 Jun 2020 03:13:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94641C06174E;
        Sat, 20 Jun 2020 00:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Wme44W2qh7tzXYn7UM4FzHwIWLWcbILhHxjrwxdLJII=; b=O/4Z+pL5WXyjcNfYPSBUsK4qu5
        4aNfC2z341IPAmYwRVZBEV3xfakWWrBlKCXxyGyw+veiaSmkoTinvaeuuARZyr97tZVJIyRoPT3xP
        GjabTkthn0HZuHDJZSzxzy1aySZL4xNgo1dSwMuRLxqErbibFOrxnI1wtidQwAkKG5Z0kCQNLC2wr
        0104h0kPS0I+zwQzDglj+OxmTeG2Nhz+2U1yGHQtQ+/wKKtkDLsk4vbKVj8tKwKxx4ZqGWa5xcuB3
        RmaVG7HOGDA8aHT87FUl12+FWLnfG34DoAuM7m79HV8uU2mYeb/TPPd38HgvAUW8/827Aj7mPapL0
        wOq2jRZg==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmXgX-00018x-3o; Sat, 20 Jun 2020 07:13:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
Subject: another libsas/ATAPI fix
Date:   Sat, 20 Jun 2020 09:13:01 +0200
Message-Id: <20200620071302.462974-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi all,

another fixup for the dma_drain vs SAS HBA issue.
