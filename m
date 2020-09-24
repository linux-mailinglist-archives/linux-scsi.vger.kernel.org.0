Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B34527780D
	for <lists+linux-scsi@lfdr.de>; Thu, 24 Sep 2020 19:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgIXRyK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 24 Sep 2020 13:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgIXRyK (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 24 Sep 2020 13:54:10 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D71FC0613CE
        for <linux-scsi@vger.kernel.org>; Thu, 24 Sep 2020 10:54:10 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id lo4so5666671ejb.8
        for <linux-scsi@vger.kernel.org>; Thu, 24 Sep 2020 10:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=dnYnUOqCTqhjFVQbMkKsuFs/tTmrE4yw9ujeSPVN1IM=;
        b=obfSpLJdEt6ttk/Q1PwvBC0ZNI+ZuObpdC5PDIgilwOvugFP1ly+hw1Qz812IEVHr2
         E8bRuXc/Ux9VjEzm2cQmMaQpEw7MEYP9F3Rxft2e2OLhjbS3UfGxCfCszNmQp+fQehFv
         ohr0cDvZpbeFVSvXmgLTWOTaeDPmCmkneTU7wmb1WTGdH5Xh4kqJtGwQPkzXC6lehHoD
         D9VrhA2QY28dpeDqy9JuROUN7g71ybdQiHtcfDkGuuh0V9F7pyxxP2Zqtpp8G8eV5HzT
         QYmIl2YsRppZVrBFGX2Nj3ozT/7xYNXj6GfoMw6qemuKZttsh/5I+EGPU2zs7i8JS+4X
         Sv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=dnYnUOqCTqhjFVQbMkKsuFs/tTmrE4yw9ujeSPVN1IM=;
        b=d/OYrxOPbYvDgYo82tVQsaJ1+JrDR8hNdIEdF5ua7kn+BLiTPtv3Rvac8E+FJloozu
         sAW/KBSNjCI7nPsQ0pizsqdHD/FTiVXjzgilkn211UhuSMkfcfOBGMLf3Ql95O1msaB8
         Eo3+sf1FudZZIG+AYc4tf9xrPup7fEdYDt2mNbwwT4DiqawCm7Lg8+zlsEd7lEzHj/iN
         uq4RR6k5qexeup0e5Y99IG36EdagYb1cmpqCTrEbs7PIPU7m3PMPo4aLcvVdVfsIg12z
         avSAVkh5M4vXxCVw3RUKbUnpmuQnFfJeh/ued7jvXg5O12Vh8c5vGt1MuI84BYuGydAS
         hQLA==
X-Gm-Message-State: AOAM530A82S1wC2/FPlyoVbbJEh4zsE6E77G/XB6Xp4FHWanDVYhZ+GG
        eXMp/lzwvBqR/gCseMustK+dl1QPgsY83/4XzHs=
X-Google-Smtp-Source: ABdhPJyBhKLKk1MttkIbz6NvjtS2R3jG7ak1U/V66UTmAZJoawK3B4Vgh87iGUE6l0CXYHaGWswssTv1Rz6t6WPNl1E=
X-Received: by 2002:a17:906:a2d2:: with SMTP id by18mr1112747ejb.37.1600970048846;
 Thu, 24 Sep 2020 10:54:08 -0700 (PDT)
MIME-Version: 1.0
Sender: marinabagni0@gmail.com
Received: by 2002:a17:906:3b0e:0:0:0:0 with HTTP; Thu, 24 Sep 2020 10:54:08
 -0700 (PDT)
From:   Marina Daniels <marinadanielsbagni1@gmail.com>
Date:   Thu, 24 Sep 2020 10:54:08 -0700
X-Google-Sender-Auth: CnpKAOMvxvUu-sahbcyqpdkmN8Y
Message-ID: <CACSWSsjZHFrPf__K939MeOq2427yz5-gP9hQwbKzzRTD_a2tHg@mail.gmail.com>
Subject: Hello Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Greetings Dear Friend,

  How are you today, together with your beloved family, which I
believe that you are all found in good health? My dear, I am sending
the same message to you for the second time praying that it will reach
you in good health, since I am not in good health in which I sleep
every night without knowing if I may be alive to see the next day.
First let me introduce myself to you My names are Mrs. Marina Bagni
Daniels, I am a widow diagnosed with brain tumor disease which has
gotten to a very bad stage which has gotten to a very bad stage and
presently I am partially suffering from a stroke illness which has
become almost impossible for me to move around. I was married to my
late husband for many years before he died, unfortunately we don't
have any children of our own, my doctor confided to me that I have
less chance to live as a result of my illness. My late husband and I
made a substantial deposit with the Bank, which I have decided to hand
over and entrust the sum of ($ 9,650,000.00) in our joint account to
you to invest into a charitable project in your country. Based on my
present health status I am permanently indisposed to handle finances
or any financial related project following my diagnoses. Having known
my present health condition, I decided to contact you to claim the
fund since I don't have any relation I grew up from the orphanage home
before i got married, I decided to donate what I have to you for the
support and mutual benefit of the orphans, gives justice and help to
the poor, needy, elderly ones, disables and to promote the words of
God and the effort that the house of God will be maintained, as I have
been touched by God to donate from what I have because it will be a
great loss in spending the fund on my health treatment hence my doctor
has confirmed to me that i will not survive this illness.

This is the reason I contacted you for your support and help to stand
as my rightful beneficiary and claim the money for humanitarian
purposes for the mutual benefits of the less privileged ones. Because
If the money remains unclaimed with the Bank after my death, those
greedy Bank Executives will place the money as an unclaimed Fund and
share it for their selfish and worthless ventures. However I needs
your sincerity and ability to carry out this transaction and fulfill
my final wish in implementing the charitable investment project in
your country as it requires absolute trust and devotion without any
failure and It will be my pleasure to compensate you with part of the
money as my Investment manager/partner for your effort in handling the
transaction, while the remaining amount of the money will be invested
into the charity project there in your country. Please I am waiting
for your prompt response if only you are interested I will give you
further details of the transaction.

Sincerely yours sister Mrs. Marina Daniels.
