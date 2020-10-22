Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A9E2956C3
	for <lists+linux-scsi@lfdr.de>; Thu, 22 Oct 2020 05:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895393AbgJVD3L (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 21 Oct 2020 23:29:11 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47162 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443905AbgJVD3K (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 21 Oct 2020 23:29:10 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id BA0682287E;
        Wed, 21 Oct 2020 23:29:07 -0400 (EDT)
Date:   Thu, 22 Oct 2020 14:29:16 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Tianxianting <tian.xianting@h3c.com>
cc:     "kashyap.desai@broadcom.com" <kashyap.desai@broadcom.com>,
        "sumit.saxena@broadcom.com" <sumit.saxena@broadcom.com>,
        "shivasharan.srikanteshwara@broadcom.com" 
        <shivasharan.srikanteshwara@broadcom.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "megaraidlinux.pdl@broadcom.com" <megaraidlinux.pdl@broadcom.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: megaraid_sas: use spin_lock() in hard IRQ
In-Reply-To: <9923f28dd2b34499a17c53e8fa33f1ca@h3c.com>
Message-ID: <alpine.LNX.2.23.453.2010221424390.6@nippy.intranet>
References: <20201021064502.35469-1-tian.xianting@h3c.com> <alpine.LNX.2.23.453.2010221312460.6@nippy.intranet> <9923f28dd2b34499a17c53e8fa33f1ca@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, 22 Oct 2020, Tianxianting wrote:

> Do you mean Megasas raid can be used in m68k arch?

m68k is one example of an architecture on which the unstated assumptions 
in your patch would be invalid. Does this help to clarify what I wrote?

If Megasas raid did work on m68k, I'm sure it could potentially benefit 
from the theoretical performance improvement from your patch.

So perhaps you would consider adding support for slower CPUs like m68k.
