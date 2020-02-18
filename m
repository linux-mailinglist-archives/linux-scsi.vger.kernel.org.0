Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83D5216376C
	for <lists+linux-scsi@lfdr.de>; Wed, 19 Feb 2020 00:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgBRXo5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Feb 2020 18:44:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45182 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgBRXo5 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 18 Feb 2020 18:44:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=PAzcezcLDjdoz/oUlECAkL2ueV0ehKmVfko930wc3ng=; b=LnbPYfOlvVJz8c5sykV3Uh/qBK
        ECHz76z5/P+GxyVB6ngAWqZhV6u5z6wofO9G063OZ1pc4qW6bIozqjqxvV1ZqcxKaWCJzbp3opfsJ
        U4nn8Rto1MaEjinuDszeVeRapy/a42mZCYaDgLvg3BcpWNbdr8L9NKG4uH3kVDsmFOWBspNZzeP6H
        Ooi1M6b59mpeVR+Ydm0EseJgjRDw8TcPLfeoSMhK5Fg75W8hbpeDzE7vZou6OjIqVDRAeAbvGMju9
        7/4Lo9Rl7I9hT6MCfr3bka2mgBR0gHo53iXQlaVLEPtdN8rXcQrzKBJRpcBF1LVg+iR9NrioldMIa
        azQSSK4w==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4CXw-00054A-L7; Tue, 18 Feb 2020 23:44:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-scsi@vger.kernel.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: ufshcd quirk cleanup
Date:   Tue, 18 Feb 2020 15:44:48 -0800
Message-Id: <20200218234450.69412-1-hch@lst.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi all,

this removes lots of dead code from the ufs drivers, an cleans
up the quirk handling a little bit.
