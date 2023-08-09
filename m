Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BEA775490
	for <lists+linux-scsi@lfdr.de>; Wed,  9 Aug 2023 09:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjHIH6j (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 9 Aug 2023 03:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjHIH6i (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 9 Aug 2023 03:58:38 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A5D1736;
        Wed,  9 Aug 2023 00:58:38 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 7087D3200932;
        Wed,  9 Aug 2023 03:58:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 09 Aug 2023 03:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wizy.org; h=cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1691567916; x=1691654316; bh=0tOO8PcOIbYkf4JRw7Q+R0CjhOkv1YFi1T+
        MMEE40Eg=; b=WdyXwBpw3EZAqLrisNZTNDrCBMOpuKhg3JmMdkA5lpA/3jPzYPq
        /nvkITCbOWu7ILSb0oqxbPCs/LV7RqgJHgxRZ20Ix1Fe2TecblN2AiYokvJlWB3r
        64H73jHGRDmb6PFSWvE8WYuaeTxJMhxriDgkEqpDA3ffAdKcU+mrSf+qfOX3PREg
        ryWN2ziGJGjOL4TUP167HBvGAYmTQ3wtwL+RzWyntM1iLaiJ9x3/xO1kaHzD3JCa
        IEQkI1ITviSlqRyN8NaIk+gYHVpIs3HIKrLm0DyvYJ0QM3cc3KwZTLQwctN4+LY7
        J9nq3bs9ciUp7jt2rgNvtt5ixHwFl3I25IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1691567916; x=
        1691654316; bh=0tOO8PcOIbYkf4JRw7Q+R0CjhOkv1YFi1T+MMEE40Eg=; b=V
        MwNzHlUpSsMVyab82bYbFSv3t6kVj5ZqfAdXXpUPHz8tNZ7o/neJZTM6hhfytdYl
        ROO+9WXBVx4d8AT0SOCZAGl71TUIi9jVkw1JosnlCdJS/gEYV0AU3nipo0HB76fz
        Zt/KeTRjuqBS1CyYs4uG099GDb06EE/J62aaC06GD/ugIxzDrI2qgw2PWlmOLzJh
        Sl4uupWOz/HasRdcMsd8TKUNyCBe4gdERe9I+zkykhvT82utUM6UFYn4KQ9qMwbC
        4X9jBeqQ9B/b0UE7Lruh6jlO2w/LskjM/VH8uNo0OT1JOfDGd4wwCpnqcgRKEa4B
        7JvgJwKRbwYb1KReROcAw==
X-ME-Sender: <xms:LEfTZFh4c66E0mI01rU3xJz9s4BZn62OryfmnbVkTnRyZcrX2Z4d-g>
    <xme:LEfTZKBpX44FcRXAHG0L_lRZpXwZS_yVPoktAGz2WyrS0AqnVf5KymyJl88lGhGkO
    LCDWaPJxsbUVmTH4kA>
X-ME-Received: <xmr:LEfTZFERZm5xhHbX1P2p8yUqXdYx30Qh8n43QwrmqEUi2_eyWvmF3Eax5crDIQ7NCr4MGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleefgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpegggfgtfffkuffhvffofhgjsehtqh
    ertdertdejnecuhfhrohhmpedftfhitggrrhguohcuvehorhhrvghirgdfuceofihiiigv
    mhgrnhesfihiiiihrdhorhhgqeenucggtffrrghtthgvrhhnpeetfeehgeeiveffgffhke
    fgtdfgjeejkefhleettdevvedvtdffkeetkeelkeeljeenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifihiivghmrghnseifihiihidrohhrgh
X-ME-Proxy: <xmx:LEfTZKSRky4t29bxwVIZMJHw4nMBEnS-C16-3CJHHVPr017SNqs7Fg>
    <xmx:LEfTZCwfIiGQBCi_uMXoMu7bTUs30A-nuoO2Z4_DFC2JqiNxuAzX1Q>
    <xmx:LEfTZA5q_yjKgHioOsGTzcz9JkVtE-Zx8-PjWXVNagn7tQZvUOFo0w>
    <xmx:LEfTZIan65d6fqMb5HZLGffpns3UgyWfpcG3AFxTqKhoZsKqttcgcg>
Feedback-ID: i46b94775:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Aug 2023 03:58:36 -0400 (EDT)
Received: by mx3.wizy.org (OpenSMTPD) with ESMTP id bdbb1d7b;
        Wed, 9 Aug 2023 07:58:34 +0000 (UTC)
Received: by wizylap.wizy.org (OpenSMTPD) with ESMTP id 0af69883;
        Wed, 9 Aug 2023 07:58:34 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 09 Aug 2023 07:58:34 +0000
Message-Id: <CUNUS3S5JHH1.3BXQVOEOYD1D9@wizylap>
Subject: Re: TRIM support not always initialized correctly
From:   "Ricardo Correia" <wizeman@wizy.org>
To:     "Ricardo Correia" <linux-usb-scsi@wizy.org>,
        <linux-usb@vger.kernel.org>, <linux-scsi@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <CUNTTPCNZJDR.3T7MC38PK0INK@wizylap>
In-Reply-To: <CUNTTPCNZJDR.3T7MC38PK0INK@wizylap>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2023-08-09 at 07:13, Ricardo Correia wrote:
> Any ideas of what could be wrong?

Never mind, this seems to be a firmware problem.
I was able to reproduce this on Windows.

Flashing a new version of the firmware also seems to have solved the issue.

Thanks.
