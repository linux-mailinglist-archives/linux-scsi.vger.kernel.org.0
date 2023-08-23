Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7EB785C2E
	for <lists+linux-scsi@lfdr.de>; Wed, 23 Aug 2023 17:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237267AbjHWPeW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 23 Aug 2023 11:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbjHWPeV (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 23 Aug 2023 11:34:21 -0400
X-Greylist: delayed 910 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Aug 2023 08:34:16 PDT
Received: from mail.parlimen.gov.my (mail.parlimen.gov.my [58.26.67.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 428B9E59
        for <linux-scsi@vger.kernel.org>; Wed, 23 Aug 2023 08:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=parlimen.gov.my; s=key01; c=relaxed/simple;
        q=dns/txt; i=@parlimen.gov.my; t=1692803864; x=2556717464;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DZK/hUNZcQiWd+YDahnFB82lNq4aIorj2cbUs+jPCnw=;
        b=YOsWOjwpBw0J5lv1Kg+GR0UVhSaLSSoc7qP19wtRpYz9egKUm2HjYMe/45sKnVZE
        SGke/K9dMCoZ0NWZ8tlxC4wT51w330ztwO94Qzn+S0dNivOqSOMU2S+75fI20wNC
        hS0Qk1L0FdnaiL914cmxL6suZ2f04CIM7jkyVwbBZIVdMQS+fkn6hG2ZxLe1B89U
        F2M09WilJkG8Eiazgspa60iYgOeVxGz1VvwoC/e/knw5yQeijvdDUg6Onk6TEv7h
        OZviui/+BxPbgEMu1IXPbHebmTAqxSRUm7veqFxty+M5CKEQ7QQeW0XmfP+oS5uc
        7EdSl4ZhwnfzzQBX9DWsww==;
X-AuditID: 0a0a1e06-e16c770000004717-8c-64e6231878ac
Received: from pmail.parlimen.gov.my (Unknown_Domain [10.0.10.134])
        by mail.parlimen.gov.my (Parlimen Mail Filtering) with SMTP id 94.40.18199.81326E46; Wed, 23 Aug 2023 23:17:44 +0800 (+08)
Received: from localhost (localhost [127.0.0.1])
        by pmail.parlimen.gov.my (Postfix) with ESMTP id 46F601C5BED9;
        Wed, 23 Aug 2023 23:17:28 +0800 (+08)
Received: from pmail.parlimen.gov.my ([127.0.0.1])
        by localhost (pmail.parlimen.gov.my [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Bcd0gdTcBzJ9; Wed, 23 Aug 2023 23:17:27 +0800 (+08)
Received: from localhost (localhost [127.0.0.1])
        by pmail.parlimen.gov.my (Postfix) with ESMTP id 245EB1C5ABCA;
        Wed, 23 Aug 2023 23:04:15 +0800 (+08)
X-Virus-Scanned: amavisd-new at pmail.parlimen.gov.my
Received: from pmail.parlimen.gov.my ([127.0.0.1])
        by localhost (pmail.parlimen.gov.my [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id v8m_duzucM-s; Wed, 23 Aug 2023 23:04:15 +0800 (+08)
Received: from [10.18.0.17] (unknown [45.87.214.118])
        by pmail.parlimen.gov.my (Postfix) with ESMTPSA id 5E4A81C553AF;
        Wed, 23 Aug 2023 22:41:37 +0800 (+08)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re:
To:     Recipients <fazlimr@parlimen.gov.my>
From:   "Ge. Capital Finance" <fazlimr@parlimen.gov.my>
Date:   Wed, 23 Aug 2023 13:41:39 -0100
Reply-To: info@gecapitalfinace.com
X-Antivirus: Avast (VPS 230823-2, 23/8/2023), Outbound message
X-Antivirus-Status: Clean
Message-Id: <20230823144138.5E4A81C553AF@pmail.parlimen.gov.my>
X-Brightmail-Tracker: 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
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_50,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hello

Sind Sie an einer finanziellen Unterst=FCtzung f=FCr den gesch=E4ftlichen o=
der privaten Bedarf f=FCr nur 2 Prozent Zinssatz interessiert? Bitte kontak=
tieren Sie uns jetzt =FCber: info@gecapitalfinace.com

Are you interested in financial assistance for business or personal use for=
 just 2 percent interest rate? Kindly contact us now via: info@gecapitalfin=
ace.com

Regard
Susan
Address: 800 Long Ridge Road
Stamford,CT 06902 United States
Phone Number: +1 7033898593
