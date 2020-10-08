Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9CE287CD8
	for <lists+linux-scsi@lfdr.de>; Thu,  8 Oct 2020 22:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbgJHUGO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 8 Oct 2020 16:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbgJHUGO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 8 Oct 2020 16:06:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD45C0613D2
        for <linux-scsi@vger.kernel.org>; Thu,  8 Oct 2020 13:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=PPV2x7/SpSZNaly+oMGigtq/9AMobjUBhXIU/XHvcvk=; b=qoOAunk6ATOLuCjRIvPHkpx8lz
        hPEkQiG8GBVlkW4Cx1nGFL5VEv3nv8jpzpat4/6XpgUJ3lAxWNnSxx4/0QEwE4zVj+iJWg4ju6QnB
        x4VdfM1/tk71B2WnGa+xRlz9UIlsR2FAgDFJg4Xe25GE0x3TC+D4VvBrByH8jtdrysRAjXKmg0ANT
        JWCX+ICIZ0IXRDIlxhA6hgYofLnyMismhzRUfjnlgN3K124gFgfUFFk0p2tvW8JSAio4QQ6OvOR8d
        EXFmcvLuDJnG8V4o6YWRyLO9cfr7EDH7kegpBa2uH/VahD2K5tjpJFBq1/FvIBYn5KiUXYGwnDrXs
        8xtq30fA==;
Received: from [2001:4bb8:184:92a2:cbfa:206d:64ea:205c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQcB2-0001RR-C5; Thu, 08 Oct 2020 20:06:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org
Subject: scsi regression fixes
Date:   Thu,  8 Oct 2020 22:06:09 +0200
Message-Id: <20201008200611.1818099-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Martin,

two regression fixes for my recently merged series, uncovered by libata.
