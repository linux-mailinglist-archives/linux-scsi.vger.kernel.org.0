Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB3D283248
	for <lists+linux-scsi@lfdr.de>; Mon,  5 Oct 2020 10:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgJEIld (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 5 Oct 2020 04:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgJEIld (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 5 Oct 2020 04:41:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E950C0613CE
        for <linux-scsi@vger.kernel.org>; Mon,  5 Oct 2020 01:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=abHFjiryUc+DVEcaA+Jd2prwP2hOjTaZhO3jC8IP+6I=; b=v54nevzfERpSojFJO0HBGfuzre
        oBbSi9q4Ug9hDNUdgaf3tW5NZpOvzJD4kVB+tGn1krKyB+X9e4Pp0sG6Qcbs8R3VJgjaZebudLEpu
        pL6tbno23FKbug0qx6TqkBPwJbe1oo0g6b7WA0UPvILNX3Std05rp3VhI5fDGUySI8p5dnZ1uaVB2
        s7iCNlgmHaL1bVka4yvYexdFq/dM9Ripdp8fXYasBjotiBLFZPO6tlAMuVP5B3meceo2RwfwNjROW
        a1WkPCtTNjITuHIl9GjHs/ydY4LutGyMbYtcK+obLetF1Y2OJ/eCIDe8KgI2DvucKlxI91x+e2Ri4
        ZpX/zo6g==;
Received: from [2001:4bb8:184:92a2:b8a4:f4a0:f053:4f06] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPM3n-0000lI-Nz; Mon, 05 Oct 2020 08:41:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org
Subject: misc I/O submission cleanups
Date:   Mon,  5 Oct 2020 10:41:20 +0200
Message-Id: <20201005084130.143273-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Martin,

this series tidies up various loose ends in the SCSI I/O submission path.
