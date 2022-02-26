Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254D44C52E1
	for <lists+linux-scsi@lfdr.de>; Sat, 26 Feb 2022 02:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240968AbiBZBCb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 25 Feb 2022 20:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbiBZBCa (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 25 Feb 2022 20:02:30 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800402036EB
        for <linux-scsi@vger.kernel.org>; Fri, 25 Feb 2022 17:01:57 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id 185so5995015qkh.1
        for <linux-scsi@vger.kernel.org>; Fri, 25 Feb 2022 17:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xLb3TQx9KxuMxtf3xcCBiCwA8sPGsTzld99AYCOXRKI=;
        b=kUtyDh9Od1BC0DBdNOhV1PkNVzRgbC8PjTK9v6zFlhsy7UQPC3IXrCoqYCji3oWOSu
         QnuEK8RkNLtgDdwJMxsQsU/C+JPxQtZuIfBRRAbAbqFhCppNW1vcefT71xasFW/Zc4z5
         hb6xkgNRpb8ml0ipN2xyXnT2x3EU1G1ENQdxcSoGuud3OlbAJV0D5xqRMQquG4v/Qclu
         jitcncorECzlzGfMmLuOhRU678LEW9dqQ3h2nd4Vga1sG/Wd0YovCjRGpBHJaZoQLORF
         U7Li549BPIslBUNnR9BndvDQMN5O1wPn28Fk8jslRByWaQL+jJtXSMsnynqn8G29FR5y
         S3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xLb3TQx9KxuMxtf3xcCBiCwA8sPGsTzld99AYCOXRKI=;
        b=uC6V+Y4ovamDzCvDf+FBrf7T2BnnAUXQtKw+ChCQpgOHCJTFclUUvvU1Ll3SK8hSeW
         n3du2/OibHfKc/+Jo+F1JLuhROWCMj80ZN6DunfCIJW01IGizhxDa+CcF/Lj9OkQbDfw
         sLdXeDCJezP1+oJkE8Ba3JAcoV/KvYssjvuRRYqR41/kFXUF0etHwTlccZzF8/b9bzRh
         Pb5Q4JG5lQOJDQvTQ2Bj8FX8DFUzcSwZT6gkmPuBX+2j3ETWczHTvx4NxYlwlyFfBOg3
         Cbj2Y6/KFTN9AqMFZW6WA+mtU3NIuzOFFBVQ++l6Qgw91YLdj0/iAvH8IK+gX0YP+pWR
         Fkdg==
X-Gm-Message-State: AOAM533x4Y4Bjv5o8ZoE2Xsp3bLz5hrWeLVMNwNSucjUQkMo+G7nUvRc
        KDTdsu440fnWUCkR8vzATGzPhSyWSfC91P7kI2Q=
X-Google-Smtp-Source: ABdhPJx9kJb5axAwpSaY5FhKoXNA9aPOqVDHxhSb+RFaWxu9YU6y0xbXaciP9kym0ilwceISTelXvoCeWwiqOwaREQ8=
X-Received: by 2002:a05:620a:12f9:b0:648:c4bb:2842 with SMTP id
 f25-20020a05620a12f900b00648c4bb2842mr6480447qkl.559.1645837316734; Fri, 25
 Feb 2022 17:01:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6214:d62:0:0:0:0 with HTTP; Fri, 25 Feb 2022 17:01:55
 -0800 (PST)
From:   Miss Reacheal <zemegnisse@gmail.com>
Date:   Sat, 26 Feb 2022 01:01:55 +0000
Message-ID: <CANkd_0wkonJO_8dwk=UnA00H1gBYb7_Hm8iYD7i-4Hf3HKPQ1w@mail.gmail.com>
Subject: Re: Hello Dear, how are you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hallo,

Sie haben meine vorherige Nachricht erhalten? Ich habe Sie schon
einmal kontaktiert, aber die Nachricht ist fehlgeschlagen, also habe
ich beschlossen, noch einmal zu schreiben. Bitte best=C3=A4tigen Sie, ob
Sie dies erhalten, damit ich fortfahren kann.

warte auf deine Antwort.

Gr=C3=BC=C3=9Fe,
Fr=C3=A4ulein Reachal
